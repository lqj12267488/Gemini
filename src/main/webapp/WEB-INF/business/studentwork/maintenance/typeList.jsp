<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/2
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <div class="block block-drop-shadow content">
        <div class="form-row block" style="overflow-y:auto;">
            <div class="form-row">
                <button type="button" class="btn btn-default btn-clean"
                        onclick="addMtType()">新增
                </button>
                <br>
            </div>
            <table id="mtTypeGrid" cellpadding="0" cellspacing="0" width="100%"
                   style="max-height: 50%;min-height: 10%;"
                   class="table table-bordered table-striped sortable_default">
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        search();
    })

    function addMtType() {
        $("#dialog").load("<%=request.getContextPath()%>/mtType/editMtType");
        $("#dialog").modal("show");
    }

    function search() {
        var table =  $("#mtTypeGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/mtType/getMtTypeList'
            },
            "destroy": true,
            "columns": [
                {"data":"mtId","visible": false},
                {"data": "mtName", "title": "类别"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.mtId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.mtId + '")/>&ensp;&ensp;';
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
            $.post("<%=request.getContextPath()%>/mtType/delMtType",{
                mtId:id
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg,type: "success"});
                    $('#mtTypeGrid').DataTable().ajax.reload();
                }
            })
        });
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/mtType/editMtType?mtId="+id);
        $("#dialog").modal("show");
    }
</script>

