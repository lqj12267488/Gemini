<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<input id="printFunds" hidden>
<div class="container"><%--最外层div--%>
    <div class="row"><%--top_extend_div--%>
        <div class="block">
            <div class="block block-drop-shadow content">
                <div class="form-row">
                    <div class="col-md-1 tar">
                        使用日期:
                    </div>
                    <div class="col-md-2">
                        <input id="date" type="date"/>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="search()">查询
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="searchClear()">清空
                        </button>
                    </div>
                </div>
            </div>
            <div class="block block-drop-shadow content">
                <div class="form-row">
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="changeAsset()">资产变更
                    </button>
                    <a class="btn btn-default btn-clean" onclick="exportList()">批量导出
                    </a>
                </div>
                <table id="assetsGrid" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                    <thead>
                    <tr>
                        <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                        </th>
                        <th>id</th>
                        <th>time</th>
                        <th>资产名称</th>
                        <th>资产类型</th>
                        <th>资产数量</th>
                        <th>计量单位</th>
                        <th>品牌</th>
                        <th>单价</th>
                        <th>规格</th>
                        <th>备注</th>
                        <th>使用部门</th>
                        <th>使用人</th>
                        <th>分配时间</th>
                        <th>位置</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#assetsGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/assets/getAssigned',
            },
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.assetsId + "'/>";
                    }
                },
                {"width": "10%", "data": "assetsId", "visible": false},
                {"width": "10%", "data": "createTime", "visible": false},
                {"width": "10%", "data": "assetsName"},
                {"width": "10%", "data": "assetsType"},
                {"width": "10%", "data": "assetsNum"},
                {"width": "10%", "data": "unit"},
                {"width": "10%", "data": "brand"},
                {"width": "7%", "data": "price"},
                {"width": "7%", "data": "specifications"},
                {"width": "10%", "data": "remark"},
                {"width": "5%", "data": "userDept"},
                {"width": "5%", "data": "userId"},
                {"width": "5%", "data": "useTimeShow"},
                {"width": "10%", "data": "usePosition"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return "" + "<a   id='upAssets' class='icon-print' title='打印' onclick='doPrint(\""+row.assetsId+"\")'></a  >&nbsp;&nbsp;&nbsp;"

                    }
                }
            ],
            "columnDefs": [{
                "orderable": false,
                "targets": [0]
            }],
            'order': [1, 'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    });

    function exportList() {
        var taskIds = "";
        if ($("#checkAll").attr("checked")) {
            taskIds = "all";
        } else {
            $('input[name="checkbox"]:checked').each(function () {
                taskIds = taskIds + "'" + $(this).val() + "',";
            });
            taskIds = taskIds.substring(0, taskIds.length - 1);
        }
        if (null == taskIds || taskIds == "") {
            swal({
                title: "请选择需要导出结果的资产信息!",
                type: "info"
            });
            return;
        }
        window.location.href = "<%=request.getContextPath()%>/assets/exportAssignedList?ids=" + taskIds;

    }

    function searchClear() {
        $("#date").val("");
        table.ajax.url("<%=request.getContextPath()%>/assets/getAssigned").load()
    }

    function search() {
        var useTime = $("#date").val();
        if ($("#date").val() == "" || $("#date").val() == undefined) {
            swal({
                title: "请填写入库时间!",
                type: "info"
            });
        } else {
            $("#assetsGrid").DataTable().ajax.url("<%=request.getContextPath()%>/assets/getAssigned?useTimeShow=" + useTime).load()
        }

    }

    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }


    function changeAsset() {
        var chk_value = "'";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + "','";
            });
            $("#dialog").load("<%=request.getContextPath()%>/assets/toChangeAsset?ids=" + chk_value + "&status=2");
            $("#dialog").modal("show");
        } else {
            swal({
                title: "请选择资产!",
                type: "info"
            });
        }

    }

    /*table.on('click', 'tr a', function () {
        var data = table.row($(this).parent()).data();
        var id = data.id;

        window.assetsId = data.assetsId;
        $("#printFunds").val("<%=request.getContextPath()%>/assets/doPrint?assetsId="+window.assetsId)
    })*/

    function doPrint(assetsId) {
        if($("#flag").val()=="1"){
            $("#audit").modal("hide");
        }
        var iframe=document.getElementById("print-iframe");
        if(!iframe){

            iframe = document.createElement('IFRAME');
            var doc = null;
            iframe.setAttribute("id", "print-iframe");
            iframe.setAttribute('style', 'position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
            document.body.appendChild(iframe);
        }
        $.get("<%=request.getContextPath()%>/assets/doPrint?assetsId="+assetsId, function (html) {
            console.log(html);
            doc = iframe.contentWindow.document;
            //这里可以自定义样式
            //doc.write("<LINK rel="stylesheet" type="text/css" href="css/print.css">");
            doc.write('<div>' + html + '</div>');
            doc.close();
            iframe.contentWindow.focus();
            iframe.contentWindow.print();
        })
    }
</script>





