<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/datatables/jquery.dataTables.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/datatables/dataTables.bootstrap.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/libs/js/plugins/datatables/language.js'></script>
<link rel="icon" type="image/ico" href="favicon.ico"/>

<body>
<div class="biaoge">
    <table>
        <tr>
            <div class="form-row1 tk1">
                <div style="overflow:hidden; display:block; width:340px; padding:7px 10px; float:left">
                    <div style="width: 100px; padding:0px 10px; display:block; float:left">分类名称：</div>
                    <input id="typeName"  style="width: 200px;" type="text"/>
                </div>
                <div style="overflow:hidden; width:140px; display:block;  padding:7px 10px; float:left">
                    <button  type="button" class="btn btn-success" onclick="search()">查询</button>
                    <button  type="button" class="btn btn-success" onclick="searchclear()">清空</button>
                </div>
                <div style="overflow:hidden; width:140px; display:block;  padding:7px 10px; float:left">
                    <button type="button"  style=" background:#ff9800;"  class="btn btn-success" onclick="addType()">新增  </button>
                </div>
            </div>
        </tr>
    </table>
    <div class="form-row tk1" style=" width:100%; padding:0px">
        <table id="tableType" cellpadding="0" cellspacing="0"
               width="100%" style="max-height: 50%;min-height: 10%; margin-left:0px; width:100%; margin-top:4px"
               class="table table-bordered table-striped sortable_default">
        </table>
    </div>
</div>
</body>
</html>
<script>
    var tableType;
    $(document).ready(function () {
        function add0(m){return m<10?'0'+m:m }
        tableType = $("#tableType").DataTable({
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
                        return '<span class="icon-edit" title="修改" onclick=editCustom("' + row.typeId + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delCustom("' + row.typeId + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function addType() {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeCustom/toResourceTypeCustomAdd");
        $("#dialog").css('display','block');
    }

    function editCustom(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/typeCustom/toResourceTypeCustomEdit?id=" + id);
        $("#dialog").css('display','block');
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
                    $('#tableType').DataTable().ajax.reload();
                }
            });
        })

    }
    function search() {
        var typeName = $("#typeName").val();
        if (typeName == "") {
        } else{
            tableType.ajax.url("<%=request.getContextPath()%>/resourceLibrary/typeCustom/getResourceTypeCustomList?typeName="+typeName).load();
        }
    }
    function searchclear() {
        $("#typeName").val("");
        tableType.ajax.url("<%=request.getContextPath()%>/resourceLibrary/typeCustom/getResourceTypeCustomList").load();
    }
</script>

<style>


</style>