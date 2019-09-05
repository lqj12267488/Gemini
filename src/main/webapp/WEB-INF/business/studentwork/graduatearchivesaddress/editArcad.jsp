<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/8/29
  Time: 18:40
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
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>省：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadProvinceEdit" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>市：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadCityEdit"  />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>县：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadCountyEdit" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>详细地址：
                    </div>
                    <div class="col-md-9">
                        <input id="arcadDetailEdit"  value="${arcadEdit.arcadDetail}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    var path = '<%=request.getContextPath()%>';

    $(function () {
        addAdministrativeDivisions("arcadProvinceEdit", "${arcadEdit.arcadProvince}", "arcadCityEdit", "${arcadEdit.arcadCity}", "arcadCountyEdit", "${arcadEdit.arcadCounty}", path);
    })
    
    function save() {

        if($("#arcadProvinceEdit").val()=="" || $("#arcadProvinceEdit").val() == undefined){
            swal({
                title: "请选择省",
                type: "info"
            });
            return;
        }
        if($("#arcadCityEdit").val()=="" || $("#arcadCityEdit").val() == undefined){
            swal({
                title: "请选择市",
                type: "info"
            });
            return;
        }
        if($("#arcadCountyEdit").val()=="" || $("#arcadCountyEdit").val() == undefined){
            swal({
                title: "请选择县",
                type: "info"
            });
            return;
        }
        if($("#arcadDetailEdit").val()=="" || $("#arcadDetailEdit").val() == undefined){
            swal({
                title: "请填写详细地址",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/arcad/saveArcad", {
            arcadId:"${arcadEdit.arcadId}",
            arcadProvince: $("#arcadProvinceEdit").val(),
            arcadCity:$("#arcadCityEdit").val(),
            arcadCounty:$("#arcadCountyEdit").val(),
            arcadDetail:$("#arcadDetailEdit").val()
        },function (msg) {
            swal({title: msg.msg,type: "success"});
            $("#dialog").modal('hide');
            $('#arcadGrid').DataTable().ajax.reload();
        })
    }
</script>
