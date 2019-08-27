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
                        <table id="arrayClassGrid" cellpadding="0" cellspacing="0"
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
            addOption(data, 's_term');
        });
        arrayClass = $("#arrayClassGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/getArrayClassList',
            },
            "destroy": true,
            "columns": [
                {"data": "arrayClassId", "visible": false},
                {"width": "30%", "data": "arrayClassName", "title": "排课计划"},
                {"width": "30%", "data": "term", "title": "学期"},
                {"width": "30%", "data": "remark", "title": "备注"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='setTeacher' class='icon-edit' title='设置排课教师'></a>" ;
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
        arrayClass.on('click', 'tr a', function () {
            var data = arrayClass.row($(this).parent()).data();
            var id = data.arrayClassId;
            if (this.id == "setTeacher") {
                $("#right").load("<%=request.getContextPath()%>/arrayClass/teacher/teacherList?arrayclassId=" + id);
            }
        });
    });

    function searchclear() {
        $("#s_arrayClassName").val("");
        $("#s_term").val("");
        search();
    }

    function search() {
        var t_arrayClassName = $("#s_arrayClassName").val();
        if(t_arrayClassName!=null && t_arrayClassName!=""){
            t_arrayClassName = "%"+ t_arrayClassName +"%";
        }
        var t_term = $("#s_term option:selected").val();
        arrayClass.ajax.url("<%=request.getContextPath()%>/arrayClass/getArrayClassList?" +
            "arrayClassName="+ t_arrayClassName+"&term="+t_term).load();
    }
</script>