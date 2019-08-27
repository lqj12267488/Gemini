<%--
  Description: 意见箱--学生--意见详情(处理意见)
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
                        主题
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="title" type="text" value="${detail.title}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        所属学院
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="majorSchoolShow" type="text" value="${detail.majorSchoolShow}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="majorCodeShow" type="text" value="${detail.majorCodeShow}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        班级
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="classShow" type="text" value="${detail.classShow}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学生姓名
                    </div>
                    <div class="col-md-10">
                        <div>
                            <input id="studentName" type="text" value="${detail.studentName}" readonly/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        内容
                    </div>
                    <div class="col-md-10">
                        <div>
                            <textarea id="suggestion" cols="30" rows="10" readonly>${detail.suggestion}</textarea>
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
