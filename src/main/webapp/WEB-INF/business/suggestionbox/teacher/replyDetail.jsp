<%--
  Description: 意见箱--教师--回复详情
  Creator: 郭千恺
  Date: 2018/9/27 10:43
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        回复人
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="replier" type="text" value="${reply.replierName}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        所属部门
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="dept" type="text" value="${reply.deptName}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        回复
                    </div>
                    <div class="col-md-10">
                        <div>
                            <textarea id="reply" cols="30" rows="10" readonly>${reply.reply}</textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
