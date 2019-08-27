<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            标题
                        </div>
                        <div class="col-md-11">
                            <input value="${data.title}" disabled />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            内容
                        </div>
                        <div class="col-md-11">
                            <textarea disabled style="height: 150px" class="form-control">${data.message}</textarea>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1 tar" >
                            留言类型
                        </div>
                        <div class="col-md-11">
                            <input value="${data.typeShow}" disabled/>
                        </div>
                    </div>
                    <div class="form-row" >
                        <div class="col-md-1 tar">
                            查看留言教师
                        </div>
                        <div class="col-md-5">
                            <input disabled value="${data.personIdShow}"  />
                        </div>

                        <div class="col-md-1 tar">
                            留言家长
                        </div>
                        <div class="col-md-5">
                            <input  disabled value="${data.creatorShow}"  />
                        </div>
                    </div>
                    <div class="form-row" >
                        <div class="col-md-1 tar">
                            留言
                        </div>
                        <div class="col-md-11">
                            <div class="content messages npb">
                                <c:forEach items="${list}" var="commentList">
                                    <div class="messages-item ${commentList.classView}">
                                        <img style="width: 30px;height: 30px;" src="<%=request.getContextPath()%>/userImg/${commentList.photoUrl}" class="img-circle img-thumbnail"/>
                                        <div class="messages-item-text">${commentList.message}</div>
                                        <div class="messages-item-date">${commentList.createTime}</div>
                                    </div>
                                </c:forEach>
                                <%--                        <div class="messages-item">     <div class="messages-item inbox">--%>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            留言：
                        </div>
                        <div class="col-md-11">
                            <textarea id="message"  style="height: 100px" class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-12 tar">
                            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="messageId" value="${id}" hidden>
</div>
<script>
    $(document).ready(function () {

    });


    function save() {
        var messageParentId = $("#messageId").val();
        var message = $("#message").val();
        if (message == "" || message == undefined || message == null) {
            swal({title: "请添加评论！",type: "info"});
            return;
        }

        $.post("<%=request.getContextPath()%>/parent/saveParentMessage", {
            messageId:'',
            title:'',
            personId:'',
            messageParentId:messageParentId,
            message:message,
        }, function (msg) {
            swal({title: msg.msg, type: "success"
            }, function () {
                $("#right").load("<%=request.getContextPath()%>/parent/toParentMessageView?id=" + messageParentId+"&identity=${identity}" );
            });
        })
    }

    function back(){
        $("#right").load("<%=request.getContextPath()%>${backurl}");
    }

</script>



