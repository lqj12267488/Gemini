<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 900px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div class="form-row block" style="overflow-y:auto;">
                <div class="form-row">
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="editRepairMan()">分配
                    </button>
                </div>
                <table id="repairManGrid" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/></th>
                        <th>id</th>
                        <th>time</th>
                        <th>rID</th>
                        <th>pId</th>
                        <th>dId</th>
                        <th width="30%">维修员姓名</th>
                        <th width="30%">维修员部门</th>
                        <th width="10">是否维修本任务</th>
                        <%--<th width="20%">修中数量</th>--%>
                        <th width="20%">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭</button>
            </button>
        </div>
    </div>
    <input id="rID" hidden value="${repair.repairID}">
</div>
<script>
    var repairManGrid;
    var pname;
    $(document).ready(function () {

       /* if (msg.status == 1) {
            swal({
                title: "该请求状态为维修完成，不可再进行分配任务！",
                type: "error"
            });
            $("#dialog").modal('hide');
        } else {
            $("#dialog").modal("show");
        }*/

        repairManGrid = $("#repairManGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/repair/searchgetDistribution?repairID='+$("#rID").val(),
            },
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.deptId +","+ row.personId + "," +$("#rID").val() + "'/>";
                    }
                },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data":"repairID","visible":false},
                {"data": "personId", "visible": false},
                {"data": "deptId", "visible": false},
                {"data": "personName"},
                {"data": "deptName"},
                {"data": "peopleFlag"},
                {
                    "width":"10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='deletePeople' class='icon-ok' title='撤销分配'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order' : [3,'desc'],
            "dom": 'rtlip',
            language: language
        });
        repairManGrid.on('click', 'tr a', function () {
            var data = repairManGrid.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "deletePeople") {
                swal({
                    title: "您确定要撤销此维修员的任务吗?",
                    text: "维修员："+data.personName,
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "提交",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/repair/deletePeople", {
                        repairID: $("#rID").val(),
                        personId:data.personId
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#repairManGrid').DataTable().ajax.reload();

                    });

                });
            }
            <%--if (this.id == "deletePeople") {--%>
                <%--$("#dialog").load("<%=request.getContextPath()%>/repair/deletePeople?repairID="+$("#rID").val());--%>
                <%--$("#dialog").modal("show");--%>

            <%--}--%>
        });
    })
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }
    function editRepairMan() {
//        var id = this.id;
//        var personName=this.personId;
//        var personDept=this.deptId;
            var chk = "'";
            if ($('input[name="checkbox"]:checked').length > 0) {
                $('input[name="checkbox"]:checked').each(function () {
                    chk += $(this).val() + "','";
                });
                swal({
                    title: "您确定要分配此任务吗?",
                    text: "分配后将无法重新分配，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/repair/FenPei?ids=" + chk,
                        function (msg) {
                            if (msg.status == 1) {
                                swal({
                                    title: msg.msg,
                                    type: "success"
                                });
                                $("#dialog").modal("hide");
                                $('#repairTable').DataTable().ajax.reload();
                            }
                        })
                });
            } else {
                swal({
                    title: "请选择维修员!",
                    type: "info"
                });
            }
    }
    function closedwindow(){
        $("input").removeAttr("readOnly");
    }

</script>