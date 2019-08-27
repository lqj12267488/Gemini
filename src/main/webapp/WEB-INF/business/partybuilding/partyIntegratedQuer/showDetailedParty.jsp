<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/27
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${party.id}">
            <input id="person" hidden value="${party.personId}">
            <input id="dept" hidden value="${party.deptId}">
            <input id="firstcultivatePeople" hidden value="${party.firstCultivatePeopleId}">
            <input id="firstcultivatePeopleDept" hidden value="${party.firstCultivatePeopleDeptId}">
            <input id="secondcultivatePeople" hidden value="${party.secondCultivatePeopleId}">
            <input id="secondcultivatePeopleDept" hidden value="${party.secondCultivatePeopleDeptId}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        成员类型：
                    </div>
                    <div class="col-md-9">
                        ${party.personType}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        姓名：
                    </div>
                    <div class="col-md-9">
                        ${party.personIdDept}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        成员来源：
                    </div>
                    <div class="col-md-9">
                        ${party.personSource}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        所属党支部：
                    </div>
                    <div class="col-md-9">
                        ${party.branchId}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        成员角色：
                    </div>
                    <div class="col-md-9">
                        ${party.memberRoles}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        第一培养人：
                    </div>
                    <div class="col-md-9">
                        ${party.firstCultivatePeopleId}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        第二培养人：
                    </div>
                    <div class="col-md-9">
                        ${party.secondCultivatePeopleId}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请入党时间：
                    </div>
                    <div class="col-md-9">
                        ${party.applyTime}
                    </div>
                </div>
                <div class="form-row" id="activeMolecular">
                    <div class="col-md-3 tar">
                        转为积极分子时间：
                    </div>
                    <div class="col-md-9">
                        ${party.activeMolecularTime}
                    </div>
                </div>

                <div class="form-row" id="development">
                    <div class="col-md-3 tar">
                        转为发展对象时间：
                    </div>
                    <div class="col-md-9">
                        ${party.developmentTime}
                    </div>
                </div>
                <div class="form-row" id="prepare">
                    <div class="col-md-3 tar">
                        转为预备党员时间：
                    </div>
                    <div class="col-md-9">
                        ${party.prepareTime}
                    </div>
                </div>
                <div class="form-row" id="joinParty">
                    <div class="col-md-3 tar">
                        转为正式党员时间：
                    </div>
                    <div class="col-md-9">
                        ${party.joinPartyTime}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注：
                    </div>
                    <div class="col-md-9">
                        ${party.remark}
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>
<script>
    $(document).ready(function () {
    })

    /* function autoComplete() {
     $("#partyMembersId").val("");
     var personType = $("#peopleType option:selected").val();
     if (personType == '0') {
     $.get("/common/getPersonDept", function (data) {
     $("#partyMembersId").autocomplete({
     source: data,
     select: function (event, ui) {
     $("#partyMembersId").val(ui.item.label);
     $("#partyMembersId").attr("keycode", ui.item.value);
     return false;
     }
     }).data("ui-autocomplete")._renderItem = function (ul, item) {
     return $("<li>")
     .append("<a>" + item.label + "</a>")
     .appendTo(ul);
     };
     })
     } else if (personType == '1') {
     $.get("/common/getStudentClass", function (data) {
     $("#partyMembersId").autocomplete({
     source: data,
     select: function (event, ui) {
     $("#partyMembersId").val(ui.item.label);
     $("#partyMembersId").attr("keycode", ui.item.value);
     return false;
     }
     }).data("ui-autocomplete")._renderItem = function (ul, item) {
     return $("<li>")
     .append("<a>" + item.label + "</a>")
     .appendTo(ul);
     };
     })
     }
     }*/
</script>


