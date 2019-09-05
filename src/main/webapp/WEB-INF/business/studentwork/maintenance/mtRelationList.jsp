<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/2
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
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



    function search() {

        if ("${relType}"=="1"){
            var table =  $("#mtRelationGrid").DataTable({
                "processing": true,
                "serverSide": true,
                "ajax": {
                    "type": "post",
                    "url": '<%=request.getContextPath()%>/mtRelation/getMRList?relType=${relType}'
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
                    "url": '<%=request.getContextPath()%>/mtRelation/getMRList?relType=${relType}'
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