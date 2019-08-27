<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <input type="hidden" name="dormId" id="dormId" value="${dormId}">
    <input type="hidden" name="id" id="id" value="${id}">
    <input type="hidden" name="sex" id="sex" value="${sex}">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  楼宇
                    </div>
                    <div class="col-md-9">
                        <select  id="lyid" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 楼层
                    </div>
                    <div class="col-md-9">
                        <select  id="lcid" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  寝室
                    </div>
                    <div class="col-md-9">
                        <select  id="qsid" onchange="changeData()" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        寝室剩余床位
                    </div>
                    <div class="col-md-9">
                        <input id="now_number"  name="now_number" readonly type="text" readonly/>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="adjustDorm()">调寝</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        //楼宇
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "id",
                text: "building_name",
                tableName: "T_JW_BUILDING",
                where: "WHERE valid_flag ='1' AND building_type ='6'",
                orderby: "ORDER BY building_name"
            }
            , function (data) {
                addOption(data, 'lyid', '${dorm.buildingId}');
            });
        //楼层
        $("#lcid").append("<option value='' selected>请选择</option>");
        $.get("<%=request.getContextPath()%>/building/getFloorByBuildingId?id="+'${dorm.buildingId}',function (data) {
            addOption(data, 'lcid','${dorm.floor}');
        });
        $("#lyid").change(function () {
            $.get("<%=request.getContextPath()%>/building/getFloorByBuildingId?id="+$("#lyid").val(),function (data) {
                addOption(data, 'lcid');
            });
        })
        //楼层联动寝室
        $("#qsid").append("<option value='' selected>请选择</option>");
        $("#lcid").change(function(){
            var qs_sql = "(select id code,DORM_NAME  value from T_JW_DORM where 1 = 1  and valid_flag = 1";
            if($("#lyid option:selected").val()!="" && $("#lcid option:selected").val()!=""  ) {
                qs_sql+= "  and BUILDING_ID ='"+$("#lyid option:selected").val()+"' and FLOOR ='"+$("#lcid option:selected").val()+"' and DORM_TYPE=${sex} ";
            }
            qs_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: qs_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "qsid");
                })
        });
    })

    //寝室联动剩余床位
    function  changeData(){

        var  qsid=$("#qsid option:selected").val();
        var  dormId=$("#dormId").val();
        if(qsid!="") {

            if(dormId==qsid){
                  swal({
                    title: "对不起，不能调至同一寝室！",
                    type: "error"
                });
                return;
            }else{
                $.get("<%=request.getContextPath()%>/dorm/getDormOverPlusNumber?dormId="+qsid, function (data) {
                    var  now_number=$("#now_number").val(data);

                });
            }
        }
    }
    //调寝
    function adjustDorm() {
        var  now_number=$("#now_number").val();
        var lyid = $("#lyid option:selected").val();
        var lcid = $("#lcid option:selected").val();
        var qsid = $("#qsid option:selected").val();
        var qstext = $("#qsid option:selected").text();
        if(lyid == "" || lyid == undefined || lyid == null){
            swal({
                title: "请选择楼宇！",
                type: "info"
            });
            return;
        }
        if(lcid == "" || lcid == undefined || lcid == null){
            swal({
                title: "请选择楼层！",
                type: "info"
            });
            return;
        }
        if(qsid == "" || qsid == undefined || qsid == null){
            swal({
                title: "请选择寝室！",
                type: "info"
            });
            return;
        }
        if(now_number==0){
            swal({
                title: "当前寝室没有空余床位!",
                type: "error"
            });
            return;
        }else{
            var  id=$("#id").val();

            swal({
                title: "您确定要调至目标寝室?",
                text: "目标寝室："+qstext+"\n\n",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "green",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                showSaveLoading();
                $.get("<%=request.getContextPath()%>/dorm/updateDormAdjustResult?dormId=${dormId}&qsid="+qsid+"&id="+id,
                    function (msg) {
                        hideSaveLoading();
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $("#dialog").modal("hide");
                            $('#adjustTable').DataTable().ajax.reload();

                    })
            });


        }

    }

</script>

