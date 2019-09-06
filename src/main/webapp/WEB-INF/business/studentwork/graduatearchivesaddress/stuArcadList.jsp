<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/8/30
  Time: 13:58
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
                                    onclick="addStuArcad()">新增
                            </button>

                            <br>
                        </div>
                        <table id="stuArcadGrid" cellpadding="0" cellspacing="0" width="100%"
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

    function addStuArcad() {
        $("#dialog").load("<%=request.getContextPath()%>/stuArcad/editStuArcad");
        $("#dialog").modal("show");
    }


    function search() {
        var table =  $("#stuArcadGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/stuArcad/getstuArcadList',
                "data": {
                    arcadProvince: $("#arcadProvinceSel").val(),
                    arcadCity: $("#arcadCitySel").val(),
                    arcadCounty: $("#arcadCountySel").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data":"id","visible": false},
                {"data":"arcadId","visible": false},
                {"data": "arcadProvinceShow", "title": "省","width":"10%"},
                {"data": "arcadCityShow", "title": "市","width":"10%"},
                {"data": "arcadCountyShow", "title": "县","width":"10%"},
                {"data": "arcadDetail", "title": "详细地址"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改学生" onclick=edit("' + row.arcadId + '")/>&ensp;&ensp;' +
                            '<span class="icon-search" title="查看" onclick=see("' + row.arcadId + '")/>&ensp;&ensp;';
                    },
                    "width":"8%"
                }
            ],
            'order': [1, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        })

    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/stuArcad/editStuArcad?arcadId="+id);
        $("#dialog").modal("show");
    }

    function see(id) {
        $("#dialog").load("<%=request.getContextPath()%>/stuArcad/seeStuArcad?arcadId="+id);
        $("#dialog").modal("show");
    }
    function searchClear(){
        $("#arcadProvinceSel").val("");
        $("#arcadCitySel").val("");
        $("#arcadCountySel").val("");
    }
</script>