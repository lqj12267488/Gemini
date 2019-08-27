<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header" style="height: 50px">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${repair.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        维修员
                    </div>
                    <div class="col-md-8">
                        <input id="addRepairmanPersonID" type="text" placeholder="请输入职工名称"
                               value="${repair.repairmanPersonID}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            console.log(data)
            $("#addRepairmanPersonID").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#addRepairmanPersonID").val(ui.item.label);
                    $("#addRepairmanPersonID").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        var ppid = $("#pid").val();
        if (ppid != "") {
            $("#addRepairmanPersonID").val("${repair.personName}");
            $("#addRepairmanPersonID").attr("keycode", "${repair.repairmanPersonID}");
        }
    })

    function closedwindow() {
        $("input").removeAttr("readOnly");
    }

    function saveDept() {
        var id = $("#id").val();
        var headT = $("#addRepairmanPersonID").attr("keycode");
        var headTList = headT.split(",");
        if ($("#addRepairmanPersonID").attr("keycode") == "" || $("#addRepairmanPersonID").attr("keycode") == "0" || $("#addRepairmanPersonID").attr("keycode") == undefined) {
            swal({
                title: "请填写后选择维修人员姓名！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/repair/checkPersonID", {
            id:$("#id").val(),
            repairmanPersonID:  headTList[1],
            deptId:  headTList[0]
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: "维修员已存在或非后勤安全处人员，请重新填写选择！",
                    type: "error"
                });
            } else {
                $.post("<%=request.getContextPath()%>/repair/saveRepairMan", {
                    id: id,
                    repairmanPersonID: headTList[1],
                    deptId: headTList[0],
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $("#dialog").modal('hide');
                        $('#repairManGrid').DataTable().ajax.reload();
                    }
                })
                showSaveLoading();
            }
        })
    }

</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end

</script>



