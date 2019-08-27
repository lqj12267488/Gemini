<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">详细</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        姓名:
                    </div>
                    <div class="col-md-3">
                        ${info.name}
                    </div>
                    <div class="col-md-3 tar">
                        证件号码:
                    </div>
                    <div class="col-md-3">
                        ${info.idcard}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        年:
                    </div>
                    <div class="col-md-3">
                        ${info.year}
                    </div>
                    <div class="col-md-3 tar">
                        月:
                    </div>
                    <div class="col-md-3">
                        ${info.month}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        应签到次数（次）:
                    </div>
                    <div class="col-md-3">
                        ${info.basicFrequency}
                    </div>
                    <div class="col-md-3 tar">
                        未签到次数（次）:
                    </div>
                    <div class="col-md-3">
                        ${info.noSignInFrequency}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        最新未签到（次）:
                    </div>
                    <div class="col-md-3">
                        ${info.latestOutOfSignIn}
                    </div>
                    <div class="col-md-3 tar">
                        调休未签到（次）:
                    </div>
                    <div class="col-md-3">
                        ${info.leaveNoSign}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        公假（天）:
                    </div>
                    <div class="col-md-3">
                        ${info.publicHolidays}
                    </div>
                    <div class="col-md-3 tar">
                        事假（次）:
                    </div>
                    <div class="col-md-3">
                        ${info.compassionateLeave}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        病假（次）:
                    </div>
                    <div class="col-md-3">
                        ${info.sickLeave}
                    </div>
                    <div class="col-md-3 tar">
                        因公（因故）误签（次）:
                    </div>
                    <div class="col-md-3">
                        ${info.wrongSignOnBusiness}
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