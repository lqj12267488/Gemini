<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/5
  Time: 10:21
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

    function search() {
        var table =  $("#diRemarkGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/diAnswer/getDiAnswerList',
                "data": {
                    reMsg:$("#reMsgSel").val(),
                    reTime:$("#reTimeSel").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data":"answerId","visible": false},
                {"data":"remarkId","visible": false},
                {"data": "reTime", "title": "时间","width":"10%"},
                {"data": "reMsg", "title": "留言内容"},
                {"data": "ansMsg", "title": "回复内容"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-comment-alt" title="回复" onclick=comment("' + row.remarkId + '","'+row.answerId+'")/>&ensp;&ensp;' +
                            '<span class="icon-upload" title="查看附件" onclick=upload("' + row.remarkId+'")/></span>&ensp;&ensp;'+
                            '<span class="icon-eye-open" title="查看" onclick=see("' + row.remarkId  + '","'+row.answerId+'")></span>';
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

    function comment(remarkId,answerId) {
        if (answerId!="" && answerId != "null"){
            swal({
                title: "该留言已回复过",
                type: "info"
            });
            return;
        }

        $("#dialog").load("<%=request.getContextPath()%>/diAnswer/editDiAnswer?remarkId="+remarkId+"&answerId="+answerId);
        $("#dialog").modal("show");
    }
    function searchClear(){
        $("#reTimeSel").val("");
        $("#reMsgSel").val("");
        search();
    }

    function upload(id) {
        $('#dialogFile').load('<%=request.getContextPath()%>/diAnswer/seefile?businessId=' + id + '&businessType=TEST&tableName=T_BG_DIREMARK');
        $('#dialogFile').modal('show');
    }

    function see(remarkId,answerId) {
        $("#dialog").load("<%=request.getContextPath()%>/diAnswer/editDiAnswer?remarkId="+remarkId+"&answerId="+answerId);
        $("#dialog").modal("show");
    }
</script>