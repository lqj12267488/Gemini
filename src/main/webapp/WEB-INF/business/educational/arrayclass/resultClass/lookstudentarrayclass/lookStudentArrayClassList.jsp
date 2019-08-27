<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/25
  Time: 15:12
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

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                排课计划：
                            </div>
                            <div class="col-md-2">
                                <input id="s_arrayClassName"/>
                            </div>
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="s_term" class="validate[required,maxSize[100]] form-control"></select>
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="arrayClassClassIdGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var arrayClass;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 's_term','${arrayClass.term}');
        });

        search();

        arrayClass.on('click', 'tr a', function () {
            var data = arrayClass.row($(this).parent()).data();
            var id = data.arrayClassId;
            if (this.id == "select") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/toSelectStudentList?arrayClassId="+id+"&arrayClassName="+data.arrayClassName);
            }
            if(this.id=="course"){
                /*$("#right").load("/arrayClassResultClass/lookStudentArrayClass");*/
                $.get("<%=request.getContextPath()%>/arrayClassResultClass/lookStudentArrayClass", function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/studentView?arrayClassName="+data.arrayClassName);
                        $("#dialog").modal('hide');
                        $("#studentArrayClassGrid").DataTable().ajax.reload();
                    }
                })
            }


        });
    })

    function searchclear() {
        $("#s_arrayClassName").val("");
        $("#s_term").val("");
        search();
    }
    function search() {
        var t_arrayClassName = '%'+$("#s_arrayClassName").val() +'%';
        var t_term = $("#s_term option:selected").val();
        arrayClass = $("#arrayClassClassIdGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/getArrayClassList',
                "data": {
                    arrayClassName:  t_arrayClassName,
                    term: t_term
                }
            },
            "destroy": true,
            "columns": [
                {"data": "arrayClassId", "visible": false},
                {"data": "termValue", "visible": false},
                {"width": "22%", "data": "arrayClassName", "title": "排课计划"},
                {"width": "22%", "data": "term", "title": "学期"},
                {"width": "22%", "data": "arrayClassFlagShow", "title": "排课状态"},
                {"width": "22%", "data": "remark", "title": "备注"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return "<a id='course' class='icon-edit' title='生成学生课表'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='select' class='icon-th-list' title='查看学生列表'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
</script>
