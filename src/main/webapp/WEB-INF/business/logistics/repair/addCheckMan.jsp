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
        <div class="modal-header" style="height: 6%">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        回检员
                    </div>
                    <div class="col-md-8">
                        <input id="checker" type="text" placeholder="请输入职工名称"
                               class="validate[required,maxSize[100]] form-control"
                               value="${repair.checker}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭</button>
        </div>
    </div>
</div>
<input id="reID" hidden value="${repair.repairID}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#checker").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#checker").val(ui.item.label);
                    $("#checker").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        var ppid = $("#pid").val();
        if(ppid!=""){
            $("#checker").val("${repair.checker}");
            $("#checker").attr("keycode", "${repair.checker}");
        }

        if($("#flag").val()=='1'||$("#flag").val()==1){
            $("#btn1").hide();
            $("input").attr('readOnly','readOnly');
            $("select").attr('disabled','disabled');
            $("textarea").attr('readOnly','readOnly');
        }

    })

    function closedwindow(){
        $("input").removeAttr("readOnly");
    }
    function saveDept() {
        if($("#checker").val() =="" || $("#checker").val() =="0" || $("#checker").val() == undefined){
            swal({
                title: "请填写维修姓名！",
                type: "info"
            });
            return;
        }
        var repairID=$("#reID").val();
        var headT = $("#checker").attr("keycode");
        var headTList = headT.split(",");
        /*alert(repairID)*/
        $.post("<%=request.getContextPath()%>/repair/saveCheckerMan", {
            repairID: repairID,
            checkerDept: headTList[0],
            checker:headTList[1]
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#repairTable').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end

</script>



