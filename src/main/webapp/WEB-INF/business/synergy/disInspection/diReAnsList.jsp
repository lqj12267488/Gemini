<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/5
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="table" cellpadding="0" cellspacing="0"
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
<script type="text/javascript">
    $(function () {
        search();
    })

    function search() {
        var table =  $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/diRemark/getDiReAnsList',
                "data": {
                    remarkId:'${remarkId}',
                }
            },
            "destroy": true,
            "columns": [
                {"data":"remarkId","visible": false},
                {"data":"answerId","visible": false},
                {"data": "answerPerson", "title": "回复人","width":"15%"},
                {"data": "ansMsg", "title": "回复内容"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-eye-open" title="查看" onclick=see("' + row.remarkId  + '","'+row.answerId+'")></span></span>';
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

    function searchClear(){
        $("#reTimeSel").val("");
        $("#reMsgSel").val("");
        search();
    }


    function see(remarkId,answerId) {
        $("#dialog").load("<%=request.getContextPath()%>/diAnswer/editDiAnswer?remarkId="+remarkId+"&answerId="+answerId);
        $("#dialog").modal("show");
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/diRemark/diRemarkList");
    }
</script>
