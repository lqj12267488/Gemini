<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
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
            <span style="font-size: 14px;">新增</span>
        </div>
        <form id="form">
            <input name="calendarId" value="${id}" hidden>
            <div class="modal-body clearfix">
                <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 月份
                        </div>
                        <div class="col-md-9">
                            <select id="month" name="month" class="required" msg="请选择月份！" maxlength="3">
                                <option value="">请选择</option>
                                <option value="一月">一月</option>
                                <option value="二月">二月</option>
                                <option value="三月">三月</option>
                                <option value="四月">四月</option>
                                <option value="五月">五月</option>
                                <option value="六月">六月</option>
                                <option value="七月">七月</option>
                                <option value="八月">八月</option>
                                <option value="九月">九月</option>
                                <option value="十月">十月</option>
                                <option value="十一月">十一月</option>
                                <option value="十二月">十二月</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 日期
                        </div>
                        <div class="col-md-9">
                            <input id="date" name="date" class="required" maxlength="5" placeholder="最多输入5个字(例：1-7)" msg="请填写正确日期！"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 周
                        </div>
                        <div class="col-md-9">
                            <input id="week" name="week" class="required" type="number" msg="请填写周！" placeholder="最多输入2个字"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 专业
                        </div>
                        <div class="col-md-9">
                            <select id="majorIdC" name="majorId" class="required" msg="请选择专业！" onchange="changeMajor()"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 班级
                        </div>
                        <div class="col-md-9">
                            <select id="classId" name="classId" class="required" msg="请选择班级！"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 上课类型
                        </div>
                        <div class="col-md-9">
                            <select id="type" name="type" class="required" maxlength="2" msg="请选择类型！">
                                <option value="">请选择</option>
                                <option value="↑↓">↑↓</option>
                                <option value="↑">↑</option>
                                <option value="↓">↓</option>
                                <option value="☆">☆</option>
                                <option value="★">★</option>
                                <option value="▲">▲</option>
                                <option value="◆">◆</option>
                                <option value="△">△</option>
                                <option value="＃">＃</option>
                                <option value="◇">◇</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getMajorCodeByDeptId?deptId=${deptId}", function (data) {
            addOption(data, 'majorIdC');
        });
        $("#classId").html("<option value=''>请选择专业</option>")
    });

    function changeMajor() {
        var majorId = $("#majorIdC").val();
        $.post("<%=request.getContextPath()%>/common/getClassIdByMajor", {
            majorCode: majorId.split(",")[0],
            trainingLevel: majorId.split(",")[1],
            majorDirection: majorId.split(",")[2],
        }, function (data) {
            addOption(data, 'classId', '${data.deptId}');
        });
    }

    function save() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#date").val().indexOf("-") < 0 || $("#date").val().split("-")[0] > 31 || $("#date").val().split("-")[1] > 31
            || $("#date").val().split("-")[0] < 0 || $("#date").val().split("-")[1] < 0) {
            swal({
                title: "请正确填写日期",
                type: "info"
            });
            return;
        }
        if (!reg.test($("#week").val())) {
            swal({
                title: "周请填写整数",
                type: "info"
            });
            return;
        }
        if ($("#week").val() < 1 || $("#week").val() > 52) {
            swal({
                title: "周填写错误,请重新填写",
                type: "info"
            });
            return;
        }
        var flag = true;
        $("form select,form input").each(function (index, item) {
            if ($(item).hasClass("required") && !$(item).val()) {
                swal({
                    title: $(item).attr("msg"),
                    type: "info"
                });
                flag = false;
                return false;
            }
        });
        if (flag) {
            showSaveLoading();
            $.post("<%=request.getContextPath()%>/courseconstruction/saveTeachingCalendarDetails", $("#form").serialize(), function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                }, function () {
                    $("#dialog").modal('hide');
                    $("#right").load("<%=request.getContextPath()%>/courseconstruction/details?id=${id}");
                });
                hideSaveLoading();
            })
        }
    }
</script>



