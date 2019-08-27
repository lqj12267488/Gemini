<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="teacherhonorId" hidden value="${teacherhonor.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <select id="deptId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        教师姓名
                    </div>
                    <div class="col-md-9">
                        <input id="person" type="text" value="${teacherhonor.teacherIdShow}"/>
                        <input id="perId" type="hidden" value="${teacherhonor.teacherId}"/>
                    </div>
                </div>
                <div class="form-row">

                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 性别
                        </div>
                        <div class="col-md-9">
                            <select id="sex" class="js-example-basic-single"></select>
                        </div>
                    <input id="sexSHOW" type="hidden" value="${teacherhonor.sex}">
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getDepartments", function (data) {
            addOption(data, 'deptId', '${teacherhonor.departmentsId}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sex', $("#sexSHOW").val());
        });


        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

    })

    function saveDept() {



        var reg = new RegExp("^[0-9]*$");
        if ($("#deptId").val() == "" || $("#deptId").val() == "0" || $("#deptId").val() == undefined) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }

        if ($("#perId").val() == "" || $("#perId").val() == undefined || $("#perId").val() == null) {
            swal({
                title: "请填写教师!",
                type: "info"
            });
            return;
        }
        if( $("#sex").val() == "" || $("#sex").val() == "0" || $("#sex").val() == undefined){
            swal({
                title: "请选择性别！",
                type: "info"
            });
            return;
        }
        if($("#person").attr("keycode")=="" || $("#person").attr("keycode") ==null){
            $("#person").attr("keycode",$("#perId").val())
        }
        $.post("<%=request.getContextPath()%>/teacherhonor/saveTeacherhonor", {
            id:$("#teacherhonorId").val(),
            teacherId: $("#perId").val(),
            departmentsId: $("#deptId").val(),
            sex: $("#sex").val()

        }, function (msg) {
            /*hideSaveLoading();*/

            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#coursehonor').DataTable().ajax.reload();
            }else{
                swal({title: msg.msg, type: msg.result});
            }
        })
       /* showSaveLoading();*/
    }

</script>

