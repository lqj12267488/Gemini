<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">

    <div class="row">
        <div class="col-md-3">
            <div class="block block-drop-shadow">
                <div class="content controls"  id="style-4" style="overflow-y:auto;height: 85%">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            姓名：
                        </div>
                        <div class="col-md-2">
                            <input id="nameSel">
                        </div>
                        <div class="col-md-1 tar">
                            证件号：
                        </div>
                        <div class="col-md-2">
                            <input id="idcardSel">
                        </div>
                        <div class="col-md-2 tar">
                            签订合同情况：
                        </div>
                        <div class="col-md-2">
                            <select id="contractTypeSel"></select>
                        </div>
                        <div class="col-md-2 tar">
                            <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                            <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="fature()">预到期人员
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="importContract()">导入
                        </button>
                        <br>
                    </div>
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
<input hidden id="deptIdHid">
<script>
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    function zTreeOnClick(event, treeId, treeNode) {
        if (treeNode.id=='0'|| treeNode.id =='001'){
            $("#deptIdHid").val("");
        }else {
            $("#deptIdHid").val(treeNode.id);
        }
        search();
    }

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            deptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            deptTree.expandAll(true);
        })


        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSHT", function (data) {
            addOption(data, 'contractTypeSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=RYXZ", function (data) {
            addOption(data, 'personNatureSel');
        });

        search();
    })

    function fature() {
        search("1");
    }

    function search(fature) {
        $("#table").DataTable({
            // "processing": true,
            // "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/TeacherContract/getTeacherContractList',
                "data": {
                    contractType: $("#contractTypeSel").val(),
                    deptId:$("#deptIdHid").val(),
                    name:$("#nameSel").val(),
                    idcard:$("#idcardSel").val(),
                    contractType:$("#contractTypeSel").val(),
                    fature:fature
                }
            },
            "destroy": true,
            "columns": [
                {"data": "personId", "visible": false},
                {"data": "deptId", "visible": false},
                {"data": "name", "title": "姓名" },
                {"data": "deptShow", "title": "所在部门"},
                {"data": "idcard", "title": "证件号"},
                {"data": "contractTypeShow", "title": "签订合同情况"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "截止时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.personId + '","'+row.deptId+'")></span>&ensp;&ensp;' +
                            '<span class="icon-eye-open" title="查看" onclick=see("' + row.personId + '","'+row.deptId+'")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            paging: true,
            language: language
        });
    }

    function searchClear() {
        $(".form-row div input,.form-row div select").val("");
        search();
    }

    function edit(personId,deptId) {
        $("#dialog").load("<%=request.getContextPath()%>/TeacherContract/toTeacherContractEdit?personId=" + personId+"&deptId="+deptId)
        $("#dialog").modal("show")
    }

    function importContract() {
        $("#dialog").load("<%=request.getContextPath()%>/TeacherContract/importContract");
        $("#dialog").modal("show");
    }

    function see(personId,deptId) {
        $("#dialog").load("<%=request.getContextPath()%>/TeacherContract/toTeacherContractEdit?personId=" + personId+"&deptId="+deptId+"&seeFlag=1")
        $("#dialog").modal("show")
    }
</script>

<style>
    #style-4::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar {
        width: 5px;
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar-thumb {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }
</style>