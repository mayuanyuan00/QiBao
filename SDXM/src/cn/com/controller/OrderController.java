package cn.com.controller;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.domain.*;
import cn.com.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;

import cn.com.common.Constants;
import cn.com.common.OrderNoGenerator;
import cn.com.utils.DateToExcelUtil;
import cn.com.utils.DateUtils;
import cn.com.vo.OderInfo;
import cn.com.vo.OrderDetailRes;
import cn.com.vo.OrderInfo;
import cn.com.vo.OrderRes;
import cn.com.vo.PageResults;

@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    private IBookService bookService;

    @Autowired
    private IOrderService orderService;

    @Autowired
    private ICartService cartService;

    @Resource(name = "linksService")
    private ILinksService linksService;

    @Resource(name = "shippingAddressService")
    private IShippingAddressService shippingAddressService;

    @Resource(name = "chartService")
    private IChartService chartService;

    /**
     * 跳转到订单修改页面
     */
    @RequestMapping("/orderInfo.do")
    public String orderInfo(@RequestParam int id, HttpServletRequest request) {
        Order order = orderService.getOrder(id);
        request.setAttribute("order", order);
        return "/admin/order/orderInfo";
    }

    /**
     * 订单提交(购物车来源)
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("cartcommit.do")
    public String commit_cart(HttpSession session, @RequestParam(value = "items", defaultValue = "") String itemsStr) throws Exception {
        Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute(Constants.SESSION.CARTINFO);
        //cart ->  order
        List<OderInfo> re = new ArrayList<>();
        Set<Integer> _list = cart.keySet();
        String[] itemIdStrs = itemsStr.split(",");
        List<Integer> items = new ArrayList<>();
        for (String item : itemIdStrs) {
            try {
                items.add(Integer.parseInt(item));
            } catch (RuntimeException ignored) {
            }
        }
        if (items.size() > 0) {
            _list = new HashSet<Integer>(items);
        }
        for (Integer in : _list) {
            Cart tCart = cart.get(in);
            Book b = bookService.findBookById(in);
            re.add(new OderInfo(b, tCart.getAmount()));
        }

        // 移除购物车中的对应商品
        for (Integer in : _list) {
            cart.remove(in);
        }

        User user = (User) session.getAttribute("user");
        int id = orderService.orderCreate(re, user.getId(), OrderNoGenerator.generate(user.getId() + ""));
        //刷新购物车
        cartService.refreshCart(cart, user.getId());
        return "redirect:orderdetailpage.do?orderid=" + id;
    }

    /**
     * 直接提交订单
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("directcommit.do")
    public String commit_direct(HttpSession session, int itemid, int count) throws Exception {
        List<OderInfo> re = new ArrayList<>();
        Book b = bookService.findBookById(itemid);
        re.add(new OderInfo(b, count));
        User user = (User) session.getAttribute("user");
        int id = orderService.orderCreate(re, user.getId(), OrderNoGenerator.generate(user.getId() + ""));
        return "redirect:orderdetailpage.do?orderid=" + id;
    }

    /**
     * 订单详情接口
     *
     * @return
     */
    @RequestMapping("orderdetail.do")
    public @ResponseBody
    String detail(HttpSession session, int orderid) {
        Gson gson = new Gson();
        return gson.toJson(orderService.getOrderDetail(orderid));
    }

//	/**
//	 * 订单修改接口
//	 * @return
//	 */
//	public String modify(){
//
//		return null;
//	}

    @RequestMapping("orderlist.do")
    public @ResponseBody
    String list(HttpSession session, int status,Integer page) {
        Gson gson = new Gson();
        return gson.toJson(orderService.getOrderList(status, ((User) session.getAttribute("user")).getId(),
                page==null?1:page).getResults());
    }

    @RequestMapping("myorderlist.do")
    public String myorderlist(HttpSession session, @RequestParam(required = false) String status,
                              @RequestParam(required = false) String orderno, HttpServletRequest request,
                              @RequestParam(required = false,defaultValue = "1")int page) {
        List<Order> _od = new ArrayList<>();
        PageResults pageResults = new PageResults();
        if (orderno != null) {
            Order order = orderService.getOrder(orderno);
            if (order != null) {
                _od.add(order);
            }
        } else if (orderno == null && status == null) {
            pageResults = orderService.getOrderList(-1, ((User) session.getAttribute("user")).getId(),page);
            _od = pageResults.getResults();
            request.setAttribute("status",-1);
        } else {
            pageResults = orderService.getOrderList(Integer.parseInt(status), ((User) session.getAttribute("user")).getId(),page);
            _od = pageResults.getResults();
            request.setAttribute("status",status);
        }
        List<OrderRes> result = new ArrayList<>();
        for (int i = 0; i < _od.size(); i++) {
            Order tod = _od.get(i);
            OrderRes or = new OrderRes();
            or.setId(tod.getId());
            or.setCount(tod.getCount());
            or.setCreate_date(DateUtils.dateToStr(tod.getCreate_date()));
            or.setStatus(tod.getStatus());
            or.setOrderno(tod.getOrderno());

            or.setOwner(tod.getOwner());
            or.setAddress(tod.getAddress());
            List<OrderDetail> listdetail = orderService.getOrderDetail(tod.getId());
            List<OrderDetailRes> detail = listdetail.stream().map(x -> new OrderDetailRes(bookService.findBookById(x.getItemid()),
                                                                    x.getAmount(), x.getUnit(), x.getCount()))
                                                                        .collect(Collectors.toList());
//			for (int j = 0; j < listdetail.size(); j++) {
//				OrderDetail _todd = listdetail.get(j);
//				OrderDetailRes _res = new OrderDetailRes();
//				_res.setAmount(_todd.getAmount());
//				_res.setCount(_todd.getCount());
//				_res.setUnit(_todd.getUnit());
//				_res.setBook(bookService.findBookById(_todd.getItemid()));
//				 detail.add(_res);
//			}
            or.setDetail(detail);
            result.add(or);
        }
        request.setAttribute("pages", pageResults);
        request.setAttribute("order", result);
        return "website/my_order_list";
    }

    @RequestMapping("orderdetailpage.do")
    public String orderdetail(int orderid, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "/website/index";
        }
        List<OrderDetail> listdetail = orderService.getOrderDetail(orderid);
        List<OrderDetailRes> detail = listdetail.stream().map(x -> new OrderDetailRes(bookService.findBookById(x.getItemid()),
                                                                x.getAmount(), x.getUnit(), x.getCount()))
                                                                    .collect(Collectors.toList());
//		for (int j = 0; j < listdetail.size(); j++) {
//			OrderDetail _todd = listdetail.get(j);
//			OrderDetailRes _res = new OrderDetailRes();
//			_res.setAmount(_todd.getAmount());
//			_res.setCount(_todd.getCount());
//			_res.setUnit(_todd.getUnit());
//			_res.setBook(bookService.findBookById(_todd.getItemid()));
//			 detail.add(_res);
//		}
        Order od = orderService.getOrder(orderid);
        List<ShippingAddress> addresses = shippingAddressService.findByUser(user.getId());
        request.getSession().setAttribute("address", addresses);
        request.setAttribute("detail", detail);
        request.setAttribute("order", od);
        if ("1".equals(od.getStatus())) {
            return "website/order_success";
        }
        return "website/order_detail";
    }


    /**
     * 订单列表
     */
    @RequestMapping("/selectOrder.do")
    public String getOrderList(@RequestParam(required = false) String date1, @RequestParam(defaultValue = "1") int page,
                               HttpServletRequest request,@RequestParam(required = false) String authority) {
        int year=0;
        int month=0;
        if(date1!=null){
             year = Integer.parseInt((date1.split("-"))[0]);
             month = Integer.parseInt((date1.split("-"))[1]);
        }
        PageResults<OrderInfo> pageResults = chartService.getOrderList(year, month, page);
        request.setAttribute("date", date1);
        request.setAttribute("list", pageResults.getResults());
        request.setAttribute("pages", pageResults);
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        return "admin/order/oderlist";
    }

    /**
     * 导出Excel表格
     */
    @RequestMapping("/downloadOrder.do")
    public String downloadOrder(@RequestParam(required = false) String date1, @RequestParam(defaultValue = "1") int page,
                                HttpServletResponse response, HttpServletRequest request) {
        int year=0;
        int month=0;
        if(date1!=null){
            year = Integer.parseInt((date1.split("-"))[0]);
            month = Integer.parseInt((date1.split("-"))[1]);
        }
        PageResults<OrderInfo> pageResults = chartService.getOrderList(year, month, page);
        List<OrderInfo> list = pageResults.getResults();
        String storeDirectoryAbs = DateToExcelUtil.getExcel(list, request);
        try {
            // path是指欲下载的文件的路径。
            File file = new File(storeDirectoryAbs);
            // 取得文件名。
            String filename = file.getName();
            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(storeDirectoryAbs));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
            file.delete();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return "admin/oderlist";
    }

    /**
     * 订单删除
     */
    @RequestMapping("/deleteOrder.do")
    public String deleteOrder(@RequestParam int id, @RequestParam(required = false) String date1,
                              @RequestParam(defaultValue = "1") int page,
                              HttpServletRequest request) {
        orderService.deleteOrder(id, "9");
        String view = "";
        if (date1 == null) {
            view = this.getOrderList(date1, page, request,(String)request.getSession().getAttribute("authority"));
        }
        return view;
    }

    /**
     * 订单修改
     */
    @RequestMapping(value = "/updateStatus.do", method = RequestMethod.POST)
    public String updateStatus(@RequestParam int id, @RequestParam String status,
                               @RequestParam String date1, @RequestParam String expno,
                               @RequestParam String express) {
        Order order = orderService.getOrder(id);
        order.setStatus(status);
        order.setExpno(expno);
        order.setExpress(express);
        orderService.updateOrder(order);
        return "redirect:/order/selectOrder.do?_date=" + date1;
    }

    /**
     * 完成订单
     */
    @RequestMapping(value = "/finishOrder.do")
    public String finishOrder(@RequestParam int id){
        Order order = orderService.getOrder(id);
        order.setStatus("7");
        orderService.updateOrder(order);
        return "redirect:/home/personalInformation.do";
    }

    /**
     * footer链接传送
     * @param model
     */
    @ModelAttribute
    public void links(Model model) {
        PageResults<Links> linksResults = linksService.getLinksByPage(1);
        List<Links> urlList = linksResults.getResults();
        model.addAttribute("urlList", urlList);
    }
}
