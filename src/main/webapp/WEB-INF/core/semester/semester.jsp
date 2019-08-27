<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <input id="speriod" type="text"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="selectName()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="clearName()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="parameterGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    var parameterGrid;

    $(document).ready(function () {
        parameterGrid = $("#parameterGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/semester/semesterList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "diccode", "visible": false},
                {"width":"25%","data": "dicname", "title": "学期"},
                {"width":"25%","data": "dictype", "title": "学年"},
                {"width":"25%","data": "name", "title": "是否当前学期"
                   /* ,
                    "render": function (data, type, row, meta) {
                            return "<span>"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
                                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
                                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
                                row.name+"</span>";
                    }*/
                },
                {
                    "width":"25%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editSemester' class='icon-ok' title='设置当前学期'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [2,'desc'],
            "dom": 'rtlip',
            language: language
        });
        parameterGrid.on('click', 'tr a', function () {
            var data = parameterGrid.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editSemester") {
                //$("#dialog").load("<%=request.getContextPath()%>/semester/updateSemester?parametervalue=" + data.dicname+"&parametername="+data.diccode);
                $.get("<%=request.getContextPath()%>/semester/updateSemester?parametervalue=" + data.diccode+"&parametername="+data.dictype, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#parameterGrid').DataTable().ajax.reload();
                    }
                })
            }
        })
    })

    function clearName() {
        $("#speriod").val("");
        selectName();
    }

    function selectName() {
        parameterGrid.ajax.url("<%=request.getContextPath()%>/semester/semesterList?dicname=" +$("#speriod").val()).load();
    }
</script>
