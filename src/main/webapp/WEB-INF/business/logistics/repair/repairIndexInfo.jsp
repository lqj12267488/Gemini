<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white" style="width: 165%;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title"> &nbsp;</h4>
        </div>
        <div class="modal-body clearfix">
            <%--<button onclick="doPrint()" class="btn btn-default btn-clean" id="dayin">打印</button>--%>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修种类:
                    </div>
                    <div class="col-md-4">${repair.repairTypeShow}
                    </div>
                    <div class="col-md-2 tar">
                        所在部门:
                    </div>
                    <div class="col-md-4">${repair.dept}
                    </div>
                    <%--<div class="col-md-2 tar">--%>
                    <%--资产编号:--%>
                    <%--</div>--%>
                    <%--<div class="col-md-4">${repair.assetsID}--%>
                    <%--</div>--%>
                </div>
                <%--<div class="form-row">--%>
                <%--<div class="col-md-2 tar">--%>
                <%--所在位置:--%>
                <%--</div>--%>
                <%--<div class="col-md-4">${repair.position}--%>
                <%--</div>--%>
                <%----%>
                <%--</div>--%>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        物品名称:
                    </div>
                    <div class="col-md-4">${repair.itemNameShow}
                    </div>
                    <div class="col-md-2 tar">
                        维修地址:
                    </div>
                    <div class="col-md-4">${repair.repairAddress}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        故障描述:
                    </div>
                    <div class="col-md-4">${repair.faultDescription}
                    </div>
                    <div class="col-md-2 tar">
                        联系方式:
                    </div>
                    <div class="col-md-4">${repair.contactNumber}
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修状态:
                    </div>
                    <div class="col-md-4" id="rflag" style="display: none;">
                        <select id="reFlag" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-4" id="rpflag" style="display: none;">${repair.requestFlagShow}
                    </div>
                </div>
                <div class="form-row">
                </div>
            </div>
            <div class="controls" id="doDiv" style="display: none;">
                <div class="col-md-2 tar">
                    <span class="iconBtx">*</span>
                    维修说明
                </div>
                <div class="col-md-9">
                        <textarea id="rcontent"
                                  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                  maxlength="165" placeholder="最多输入165个字">${repair.repairResult}</textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="doRepair" class="btn btn-default btn-clean"
                    onclick="yesRepair()" style="display: none;">确认维修
            </button>
            <button type="button" id="fenRepair" class="btn btn-default btn-clean" data-dismiss="modal"
                    onclick="fpRepair()" style="display: none;">维修分配
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="yesReaded()">已读
            </button>

            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>

        </div>
    </div>
</div>
<script>
    var flag =${flag};
    var repairID = '${repair.repairID}';
    $(document).ready(function () {
        if ('${repair.requestFlagShow}' == "维修未完成") {
            $.post("<%=request.getContextPath()%>/repair/checkRequestFlag", {
                repairID: repairID
            }, function (msg) {
                if (msg.status != 1) {
                    document.getElementById("doRepair").style.display = "";
                    document.getElementById("doDiv").style.display = "";
                    document.getElementById("rflag").style.display = "";
                    $.get("<%=request.getContextPath()%>/common/getSysDict?name=WXLCZT" + "&where= " + "(dic_code='2' or dic_code='3')",
                        function (data) {
                            addOption(data, "reFlag", '${repair.requestFlag}');
                        });
                }
            })
        }
        if ('${repair.requestFlagShow}' == "维修分配中") {
            // document.getElementById("fenRepair").style.display = "";
            document.getElementById("rpflag").style.display = "";
        } else {
            document.getElementById("rpflag").style.display = "";
        }
    })

    function yesReaded() {
        var repairID = '${repair.repairID}';
        swal({
            title: "确定将本条信息标记为已读?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/repair/insertRepairLog", {
                repairID: repairID,
                flag: flag
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"}, function () {
                        //$("#eChartsP").reload("<%=request.getContextPath()%>/index");
                        window.location.href = "<%=request.getContextPath()%>/index?system=GLPT&id=001";
                    });
                }


            });
        })
    }

    function yesRepair() {
        if ($("#rcontent").val() == "" || $("#rcontent").val() == "0" || $("#rcontent").val() == undefined) {
            swal({
                title: "请填写维修说明！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/repair/saveContent", {
            repairID: repairID,
            requestFlag: $("#reFlag").val(),
            content: $("#rcontent").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                window.location.href = "<%=request.getContextPath()%>/index?system=GLPT&id=001";
                <%--$("#unAudit").load("<%=request.getContextPath()%>/loadIndexUnAudit");--%>
            }
        })


    }

    function fpRepair() {
        $("#dialog").load("<%=request.getContextPath()%>/repair/getDistribution?repairID=" + repairID);
        $("#dialog").modal("show");
    }
</script>