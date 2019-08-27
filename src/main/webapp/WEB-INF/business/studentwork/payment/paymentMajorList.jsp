<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <input id="hiddenYear" name="hiddenYear" type="hidden" value="${year}">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部:
                            </div>
                            <div class="col-md-2">
                                <select id="did" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业:
                            </div>
                            <div class="col-md-2">
                                <select id="mid" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                招生年份:
                            </div>
                            <div class="col-md-2">
                                <select id="year" class="js-example-basic-single"></select>
                            </div>
                        </div>
                    </div>
                    <div class="content block-fill-white" >
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                培养层次:
                            </div>
                            <div class="col-md-2">
                                <select id="tid" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                学制:
                            </div>
                            <div class="col-md-2">
                                <select id="system" class="js-example-basic-single"></select>
                            </div>

                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="batchAddMajorCost()">批量维护
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="batchDelCost()">批量删除
                        </button>
                    </div>

                    <table id="costMajorGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>
                            <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                            </th>
                            <th>majorId</th>
                            <th>departmentsId</th>
                            <th>majorCode</th>
                            <th>trainingLevel</th>
                            <th>majorDirection</th>
                            <th>schoolSystem</th>
                            <th width="10%">系部</th>
                            <th width="10%">专业</th>
                            <th width="10%">培养层次</th>
                            <th width="10%">方向</th>
                            <th width="10%">学制</th>
                            <th width="10%">招生年份</th>
                            <th width="10%">费用</th>
                            <th width="10%">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    var dothis ="<a id='addMajorCost' class='icon-cogs' title='设置'></a>&nbsp;&nbsp;&nbsp;"+
        "<a id='delMajorCost' class='icon-trash' title='删除'></a>";
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " order by dept_id "
            },
            function (data) {
                addOption(data, "did", $("#up_departments").val());
            })
        //系部联动专业
        $("#did").change(function(){
            var major_sql = "(select distinct major_code  code,major_name   value from t_xg_major where 1=1  and valid_flag = 1";
            if($("#did option:selected").val()!="") {
                major_sql+= " and departments_id ='"+$("#did option:selected").val()+"' ";
            }
            major_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "mid");
                })
        });


        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYXZ", function (data) {
            addOption(data, 'system');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYPYCC", function (data) {
            addOption(data, 'tid');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year',$("#hiddenYear").val());
        });
        table = $("#costMajorGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/payment/major/getPaymentPlanList?flag=manage',
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='"+row.majorId+"'/>";
                    }
                },
                {"data": "majorId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "majorDirection", "visible": false},
                {"data": "schoolSystem", "visible": false},
                {"width": "10%", "data": "departmentShow", "title": "系部"},
                {"width": "10%", "data": "majorShow", "title": "专业"},
                {"width": "10%", "data": "directionShow", "title": "专业方向"},
                {"width": "10%", "data": "trainingShow", "title": "培养层次"},
                {"width": "10%", "data": "systemShow", "title": "学制"},
                {"width": "10%", "data": "year", "title": "招生年份"},
                {"width": "10%", "data": "majorFee", "title": "费用"},
                {"width":"10%","title": "操作","render": function () {return dothis;}}
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order' : [[2,'asc'],[3,'desc'],[4,'desc'],[5,'desc'],[6,'desc']],
            "dom": 'rtlip',
            "language": language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var majorId = data.majorId;
            var majorShow = data.majorShow;
            var directionShow = data.directionShow;
            var trainingShow = data.trainingShow;
            var systemShow = data.systemShow;
            var year = data.year;
            if (this.id == "addMajorCost") {
                $("#dialog").load("<%=request.getContextPath()%>/payment/major/addMajorCost?majorId="+majorId+"&year="+year);
                $("#dialog").modal("show");
            }
            if (this.id == "delMajorCost") {
                swal({
                    title: "您确定要删除此条专业的专业费用信息?",
                    text: "专业名称："+majorShow+"，专业方向："+directionShow+"，培养层次："+trainingShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/payment/major/del?id="+majorId+"&year="+year, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                        }else{
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#costMajorGrid').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    })


    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }


    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#tid").val("");
        $("#system").val("");
        $("#year").val($("#hiddenYear").val());
        table.ajax.url("<%=request.getContextPath()%>/payment/major/getPaymentPlanList?flag=manage").load();
    }

    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var tid = $("#tid option:selected").val();
        var system = $("#system option:selected").val();
        var year = $("#year option:selected").val();

        table.ajax.url("<%=request.getContextPath()%>/payment/major/getPaymentPlanList?departmentsId="+did+"&majorCode="+mid+"&trainingLevel="+tid+"&schoolSystem="+system+"&year="+year).load();
    }

    function batchAddMajorCost() {
        var  year=$("#year").val();
        var  hiddenYear=$("#hiddenYear").val();
        var ids = '';
        var id = "";
        var length=$('input[name="checkbox"]:checked').length;
        if (length > 1) {
            $('input[name="checkbox"]:checked').each(function () {
                ids+="'" + $(this).val()  +"',";
                id += $(this).val() + ",";

            });
            ids = ids.substring(0,ids.length-1);
            if(year==null || year==""){
                $("#dialog").load("<%=request.getContextPath()%>/payment/major/batchAddMajorCost?ids="+ids+"&id="+id+"&year="+hiddenYear);
                $("#dialog").modal("show");
            }else{
                $("#dialog").load("<%=request.getContextPath()%>/payment/major/batchAddMajorCost?ids="+ids+"&id="+id+"&year="+year);
                $("#dialog").modal("show");
            }

        } else if(length<2){
            swal({
                title: "请至少选择两个专业!",
                type: "info"
            });
        }else{
            swal({
                title: "请选择要添加的专业!",
                type: "info"
            });
        }

    }

    function batchDelCost() {
        var  year=$("#year").val();
        var  hiddenYear=$("#hiddenYear").val();
        var ids = '';
        var id = "";
        var length=$('input[name="checkbox"]:checked').length;
        if (length > 1) {
            $('input[name="checkbox"]:checked').each(function () {
                ids+="'" + $(this).val()  +"',";
                id += $(this).val() + ",";

            });
            ids = ids.substring(0,ids.length-1);
            swal({
                title: "您确定要批量删除招生计划信息?",
                //text: "专业名称："+majorShow+"，专业方向："+directionShow+"，专业层次："+trainingLevelShow+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                if(year==null || year==""){
                    $.get("<%=request.getContextPath()%>/payment/major/batchDelCost?ids="+ids+"&id="+id+"&year="+hiddenYear, function (data) {
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                        $('#costMajorGrid').DataTable().ajax.reload();
                    })
                }else{
                    $.get("<%=request.getContextPath()%>/payment/major/batchDelCost?ids="+ids+"&id="+id+"&year="+year, function (data) {
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                        $('#costMajorGrid').DataTable().ajax.reload();
                    })
                }

            });

        } else if(length<2){
            swal({
                title: "请至少选择两个专业!",
                type: "info"
            });
        }else{
            swal({
                title: "请选择要删除的专业!",
                type: "info"
            });
        }

    }

</script>
