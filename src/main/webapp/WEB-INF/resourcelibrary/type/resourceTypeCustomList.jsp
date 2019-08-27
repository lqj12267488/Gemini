<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white" hidden="">
                    &nbsp;
                </div>
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addCustom()">新增
                            </button>
                            <br>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="tableCustom" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var tableCustom;
    $(document).ready(function () {
        function add0(m){return m<10?'0'+m:m }
        tableCustom = $("#tableCustom").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourceLibrary/typeCustom/getResourceTypeCustomList',
            },
            "destroy": true,
            "columns": [
                {"data":"typeId","visible": false},
                {"data":"typeName","title":"分类名称"},
                {
                    "title": "新增时间",
                    "render": function (data, type, row) {
                        var time = new Date(row.createTime);
                        var y = time.getFullYear();
                        var m = time.getMonth()+1;
                        var d = time.getDate();
                        var h = time.getHours();
                        var mm = time.getMinutes();
                        var s = time.getSeconds();
                        return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm)+':'+add0(s);
                    }
                },
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改111" onclick=editCustom("' + row.typeId + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除222" onclick=delCustom("' + row.typeId + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function addCustom() {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeCustom/toResourceTypeCustomAdd")
        $("#dialog").modal("show")
    }

    function editCustom(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeCustom/toResourceTypeCustomEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function delCustom(id) {
        swal({
            title: "确定要删除这条记录?",
            text: "",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourceLibrary/typeCustom/delResourceTypeCustom", {
                id: id
            }, function (msg) {
                swal({title: msg.msg,type: msg.result});
                if(msg.status=='1' || msg.status==1) {
                    $('#tableCustom').DataTable().ajax.reload();
                }
            });
        })
    }
</script>