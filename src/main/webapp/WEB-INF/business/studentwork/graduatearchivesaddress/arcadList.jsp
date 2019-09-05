<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/8/29
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                省：
                            </div>
                            <div class="col-md-2">
                                <select id="arcadProvinceSel"> </select>
                            </div>
                            <div class="col-md-1 tar">
                                市：
                            </div>
                            <div class="col-md-2">
                                <select id="arcadCitySel" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                县：
                            </div>
                            <div class="col-md-2">
                                <select id="arcadCountySel" type="text"/>
                            </div>
                        </div>
                        <div class="form-row">

                            <div class="col-md-1 tar">
                                详细地址：
                            </div>
                            <div class="col-md-2">
                                <input id="arcadDetailSel" type="text"/>
                            </div>
                            <div class="col-md-2 tar">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addArcad()">新增
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="importArcadTemplate()">下载导入模板
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="importArcad()">导入
                            </button>
                            <br>
                        </div>
                        <table id="arcadGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var path = '<%=request.getContextPath()%>';
    $(function () {
        addAdministrativeDivisions("arcadProvinceSel", "", "arcadCitySel", "", "arcadCountySel", "", path);
        search();
    })

    function addArcad() {
            $("#dialog").load("<%=request.getContextPath()%>/arcad/editArcad");
            $("#dialog").modal("show");
    }
    function importArcadTemplate() {
        window.location.href = "<%=request.getContextPath()%>/arcad/importArcadTemplate";
    }
    function importArcad() {
        $("#dialog").load("<%=request.getContextPath()%>/arcad/importArcad");
        $("#dialog").modal("show");
    }

    function search() {

        var table =  $("#arcadGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arcad/getArcadList',
                "data": {
                    arcadProvince: $("#arcadProvinceSel").val(),
                    arcadCity: $("#arcadCitySel").val(),
                    arcadCounty: $("#arcadCountySel").val(),
                    arcadDetail: $("#arcadDetailSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data":"arcadId","visible": false},
                {"data": "arcadProvinceShow", "title": "省"},
                {"data": "arcadCityShow", "title": "市"},
                {"data": "arcadCountyShow", "title": "县"},
                {"data": "arcadDetail", "title": "详细地址"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.arcadId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.arcadId + '")/>&ensp;&ensp;';
                    }
                }
            ],
            'order': [1, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        })

    }

    function del(id){
        swal({
            title: "您确定要删除本条信息?",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/arcad/delArcad",{
                arcadId:id
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg,type: "success"});
                    $('#arcadGrid').DataTable().ajax.reload();
                }
            })
        });
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/arcad/editArcad?arcadId="+id);
        $("#dialog").modal("show");
    }
    function searchClear(){
        $("#arcadProvinceSel").val("");
        $("#arcadCitySel").val("");
        $("#arcadCountySel").val("");
        $("#arcadDetailSel").val();
    }
</script>
