<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/4
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                日期：
                            </div>
                            <div class="col-md-2">
                                <input id="reTimeSel" type="date"> </input>
                            </div>
                            <div class="col-md-1 tar">
                                内容：
                            </div>
                            <div class="col-md-2">
                                <input id="reMsgSel" type="text"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addDiRemark()">新增
                            </button>
                            <br>
                        </div>
                        <table id="diRemarkGrid" cellpadding="0" cellspacing="0" width="100%"
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

    function addDiRemark() {
        $("#dialog").load("<%=request.getContextPath()%>/diRemark/editDiRemark");
        $("#dialog").modal("show");
    }

    function search() {
        var table =  $("#diRemarkGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/diRemark/getDiRemarkList',
                "data": {
                    reMsg:$("#reMsgSel").val(),
                    reTime:$("#reTimeSel").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data":"remarkId","visible": false},
                {"data": "reTime", "title": "时间","width":"10%"},
                {"data": "reMsg", "title": "留言内容"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.remarkId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.remarkId + '")/>&ensp;&ensp;'+
                            '<span class="icon-upload" title="上传,查看,下载附件" onclick=upload("' + row.remarkId+'")/></span>&ensp;&ensp;'+
                            '<span class="icon-eye-open" title="查看" onclick=see("' + row.remarkId + '")></span>';
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

    function del(id){
        swal({
            title: "请确认是否要删除?",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/diRemark/delDiRemark",{
                remarkId:id
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg,type: "success"});
                    $('#diRemarkGrid').DataTable().ajax.reload();
                }
            })
        });
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/diRemark/editDiRemark?remarkId="+id);
        $("#dialog").modal("show");
    }
    function searchClear(){
        $("#reTimeSel").val("");
        $("#reMsgSel").val("");
        search();
    }

    function upload(id) {
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_DIREMARK');
        $('#dialogFile').modal('show');
    }
    
    function see(id) {
        $("#right").load("<%=request.getContextPath()%>/diRemark/diReAnsList?remarkId="+id)
    }
</script>