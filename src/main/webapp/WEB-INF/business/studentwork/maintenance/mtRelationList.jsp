<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/2
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                <c:if test='${relType == 1}'>教室号</c:if>
                                <c:if test='${relType == 2}'>寝室号</c:if>
                            </div>
                            <div class="col-md-2">
                                <input id="relNameSel">
                            </div>
                            <div class="col-md-1 tar">
                                状态：
                            </div>
                            <div class="col-md-2">
                                <select id="statusSel">
                                    <option value="请选择">请选择</option>
                                    <option value="0">未维护</option>
                                    <option value="1">已维护</option>
                                </select>
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
                        <table id="mtRelationGrid" cellpadding="0" cellspacing="0" width="100%"
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
    $(function () {
        search();
    })

function searchClear() {
   $("#relNameSel").val("");
   $("#statusSel").val("")
    search();
}

    function search() {

        if ("${relType}"=="1"){
              $("#mtRelationGrid").DataTable({
                "processing": true,
                "serverSide": true,
                "ajax": {
                    "type": "post",
                    "url": '<%=request.getContextPath()%>/mtRelation/getMRList',
                    "data":{
                        relType:"${relType}",
                        relName:$("#relNameSel").val(),
                        mtStatus:$("#statusSel").val()
                    }
                },
                "destroy": true,
                "columns": [
                    {"data":"relId","visible": false},
                    {"data":"relName","title": "教室号"},
                    {"data": "mtStatus", "title": "状态"},
                    {
                        "title": "操作",
                        "render": function (data, type, row) {
                            return '<span class="icon-search" title="修改" onclick=edit("' + row.relId + '")/>'
                        },
                        "width":"10%"
                    }
                ],
                'order': [1, 'desc'],
                paging: true,
                "dom": 'rtlip',
                language: language
            })
        } else {
            $("#mtRelationGrid").DataTable({
                "processing": true,
                "serverSide": true,
                "ajax": {
                    "type": "post",
                    "url": '<%=request.getContextPath()%>/mtRelation/getMRList',
                    "data":{
                        relType:"${relType}",
                        relName:$("#relNameSel").val(),
                        mtStatus:$("#statusSel").val()
                    }
                },
                "destroy": true,
                "columns": [
                    {"data":"relId","visible": false},
                    {"data":"relName","title": "寝室号"},
                    {"data": "mtStatus", "title": "状态"},
                    {
                        "title": "操作",
                        "render": function (data, type, row) {
                            return '<span class="icon-search" title="维护" onclick=edit("' + row.relId + '")/>'
                        },
                        "width":"10%"
                    }
                ],
                'order': [1, 'desc'],
                paging: true,
                "dom": 'rtlip',
                language: language
            })
        }
    }


    function edit(id) {
        $("#right").load("<%=request.getContextPath()%>/mtRelation/editMR?relType=${relType}&relId="+id);
    }
</script>