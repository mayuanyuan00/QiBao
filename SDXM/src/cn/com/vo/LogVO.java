package cn.com.vo;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/12
 * @Modefied By
 */
public class LogVO {

    private String id;
    private String operator;
    private String operationContent;
    private String operationDate;

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public void setOperationContent(String operationContent) {
        this.operationContent = operationContent;
    }

    public void setOperationDate(String operationDate) {
        this.operationDate = operationDate;
    }

    public String getOperationDate() {

        return operationDate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOperator() {
        return operator;
    }

    public String getOperationContent() {
        return operationContent;
    }
}
