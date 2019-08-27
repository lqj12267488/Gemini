<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">资产分配</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <form>
                    <input name="ids" value="${ids}" hidden>
                    <c:forEach items="${assets}" var="asset">
                        <div class="form-row">
                            <div class="col-md-3">
                                资产名称：
                            </div>
                            <div class="col-md-6">
                                    ${asset.assetsName}
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3">
                                <span class="iconBtx">*</span>
                                分配数量：
                            </div>
                            <div class="col-md-6">
                                <input id="${asset.id}" name="${asset.id}" placeholder="请输入数字"
                                       assetsName="${asset.assetsName}"
                                       numIn="${asset.assetsNumIn}"/>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="form-row">
                        <div class="col-md-3">
                            <span class="iconBtx">*</span>
                            分配类型：
                        </div>
                        <div class="col-md-6">
                            <select id="useType" name="useType" onchange="changeUseType(this)">
                                <option value="1">个人分配</option>
                                <option value="2">部门分配</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div id="fp" class="col-md-3">
                            <span class="iconBtx">*</span>
                            姓名：
                        </div>
                        <div class="col-md-6">
                            <input id="person" placeholder="请输入职工名称">
                            <input id="dept" hidden>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3">
                            <span class="iconBtx">*</span>
                            使用时间：
                        </div>
                        <div class="col-md-6">
                            <input id="useTime" name="useTime" type="date">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3">
                            <span class="iconBtx"> </span>
                            位置：
                        </div>
                        <div class="col-md-6">
                            <input id="usePosition" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                   maxlength="65" placeholder="最多输入65个字"
                                   name="usePosition">
                        </div>
                    </div>
                </form>
            </div>
        </div>
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
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    });

    function changeUseType(select) {
        if ($(select).val() == "1") {
            $("#fp").text("姓名：");
            $("#dept").hide();
            $("#person").show();
        }
        if ($(select).val() == "2") {
            $("#fp").text("部门：");
            $("#person").hide();
            $("#dept").show();
        }

    }

    function save() {
        var ids = '${ids}';
        var temp = ids.split(",");
        for (var i = 0; i < temp.length; i++) {
            var numIn = $("#" + temp[i]).attr("numin");
            var val = $("#" + temp[i]).val();
            var assetsName = $("#" + temp[i]).attr("assetsName");
            if (val == "undefined" || val == "" || val == null) {
                swal({
                    title: "分配数量不能为空！",
                    type: "info"
                });
                return;
            } else if (isNaN(val)) {
                swal({
                    title: assetsName + "分配数量只能位数字！",
                    type: "info"
                });
                return;
            } else if (eval(val) > eval(numIn)) {
                swal({
                    title: assetsName + "分配数量不能大于在库数量！",
                    type: "info"
                });
                return;
            }

        }
        var useTime = $("#useTime").val();
        if (useTime == "" || useTime == undefined || useTime == null) {
            swal({
                title: "请填写使用时间!",
                type: "info"
            });
            return;
        }
        var data = $("form").serializeArray();
        if ($("#useType").val() == "1") {
            var personId = $("#person").attr("keycode");
            if (personId == "" || personId == undefined || personId == null) {
                swal({
                    title: "请填写人员姓名!",
                    type: "info"
                });
                return;
            } else {
                data.push({name: 'personId', value: personId});
            }
        }
        if ($("#useType").val() == "2") {
            var deptId = $("#dept").val();
            if (deptId == "" || deptId == undefined || deptId == null) {
                swal({
                    title: "请选择部门!",
                    type: "info"
                });
                return;
            } else {
                data.push({name: 'deptId', value: deptId});
            }
        }
        $.post("<%=request.getContextPath()%>/assets/allot", data, function (msg) {
            hideSaveLoading();
            if (msg.status == 0 ) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $("#dialog").modal('hide');
                    $('#assetsGrid').DataTable().ajax.reload();
                });
            }
        })
        showSaveLoading();
    }
</script>



