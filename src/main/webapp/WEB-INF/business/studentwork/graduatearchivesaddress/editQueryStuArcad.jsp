<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/2
  Time: 10:57
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
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>省：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadProvinceEdit" onchange="arcadProvinceChange()" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>市：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadCityEdit"  onchange="arcadCityChange()"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>县区：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadCountyEdit"  onchange="arcadCountyChange()" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>详细地址：
                    </div>
                    <div class="col-md-9">
                        <select id="arcadDetailEdit" />
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
    $(function () {
        <%--获取省--%>
        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict", {
                id: " t.arcad_province ",
                text: "  FUNC_GET_TABLEVALUE(t.arcad_province,'T_SYS_ADMINISTRATIVE_DIVISIONS', 'ID', 'NAME')",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where:" where  t.valid_flag = '1'"
            },
            function (data) {
                addOption(data, "arcadProvinceEdit",'${stuArcadEdit.arcadProvince}');
            });

        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict", {
                id: " t.arcad_city ",
                text: "  FUNC_GET_TABLEVALUE(t.arcad_city,'T_SYS_ADMINISTRATIVE_DIVISIONS', 'ID', 'NAME')",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where:" where  t.valid_flag = '1' and t.arcad_province = '"+'${stuArcadEdit.arcadProvince}'+"'"
            },
            function (data) {
                addOption(data, "arcadCityEdit",'${stuArcadEdit.arcadCity}');
            });


        $.get("<%=request.getContextPath()%>/common/getDistinctTableDict", {
                id: " t.arcad_county ",
                text: "  FUNC_GET_TABLEVALUE(t.arcad_county,'T_SYS_ADMINISTRATIVE_DIVISIONS', 'ID', 'NAME')",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where:" where  t.valid_flag = '1' and t.arcad_province = '"+'${stuArcadEdit.arcadProvince}'+"' and t.arcad_city= '"+'${stuArcadEdit.arcadCity}'+"'"
            },
            function (data) {
                addOption(data, "arcadCountyEdit",'${stuArcadEdit.arcadCounty}');
            });



        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " t.arcad_detail ",
                text: " t.arcad_detail ",
                tableName: "  T_XG_ARCHIVESADDR t ",
                where: "  WHERE t.arcad_province = '"+'${stuArcadEdit.arcadProvince}'+"' and t.arcad_city= '"+'${stuArcadEdit.arcadCity}'+"'and  t.arcad_county ='"+'${stuArcadEdit.arcadCounty}'+"' and t.valid_flag = '1'",
            },
            function (data) {
                addOption(data, "arcadDetailEdit",'${stuArcadEdit.arcadDetail}');
            });
    })


    function save() {
        $.post("<%=request.getContextPath()%>/stuArcad/saveQueryStuArcad", {
            id:'${stuArcadEdit.id}',
            arcadProvince: $("#arcadProvinceEdit").val(),
            arcadCity:$("#arcadCityEdit").val(),
            arcadCounty:$("#arcadCountyEdit").val(),
            arcadDetail:$("#arcadDetailEdit").val()
        },function (msg) {
            swal({title: msg.msg,type: "success"});
            $("#dialog").modal('hide');
            $('#stuArcadGrid').DataTable().ajax.reload();
        })
    }
</script>
