<%--
  Description: 
  Creator: 郭千恺
  Date: 2018/10/8 10:52
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
                    <div class="col-md-4 tar">
                        专业名称
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="majorShow" type="text" value="${detail.majorShow}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        专业建设指导委员会职务
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="cmtePost" type="text" value="${detail.cmtePost}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        姓名
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="teacherName" type="text" value="${detail.teacherName}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        工作单位
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="workUnit" type="text" value="${detail.workUnit}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        职务
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="teacherPost" type="text" value="${detail.teacherPost}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        职称
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="teacherTitle" type="text" value="${detail.teacherTitle}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-4 tar">
                        联系电话
                    </div>
                    <div class="col-md-8">
                        <div>
                            <input id="telephone" type="text" value="${detail.telephone}" readonly/>
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
