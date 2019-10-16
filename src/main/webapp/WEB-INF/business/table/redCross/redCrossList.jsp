<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow" id="div">
                    <div class="content block-fill-white">
                        <div class="form-row">
                                                    <div class="col-md-1 tar">
                                学校分管部门：
                            </div>
                            <div class="col-md-2">
                                <input id="departmentSel">
                                <input id="hiddenId" hidden>
                            </div>
                            <div class="col-md-1 tar">
                                社团代码：
                            </div>
                            <div class="col-md-2">
                                <input id="communitycodeSel">
                            </div>
                            <div class="col-md-1 tar">
                                社团名称：
                            </div>
                            <div class="col-md-2">
                                <input id="communitynameSel">
                            </div>
                            <div class="col-md-1 tar">
                                成立日期：
                            </div>
                            <div class="col-md-2">
                                <input type="date" id="founddateSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                总数：
                            </div>
                            <div class="col-md-2">
                                <input id="sumSel">
                            </div>
                            <div class="col-md-1 tar">
                                教工数：
                            </div>
                            <div class="col-md-2">
                                <input id="teachingstaffnumberSel">
                            </div>
                            <div class="col-md-1 tar">
                                学生数：
                            </div>
                            <div class="col-md-2">
                                <input id="studentnumberSel">
                            </div>
                            <div class="col-md-1 tar">
                                总数：
                            </div>
                            <div class="col-md-2">
                                <input id="moneynumSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                上交：
                            </div>
                            <div class="col-md-2">
                                <input id="handinSel">
                            </div>
                            <div class="col-md-1 tar">
                                留存自用：
                            </div>
                            <div class="col-md-2">
                                <input id="selfSel">
                            </div>
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="nameSel">
                            </div>
                            <div class="col-md-1 tar">
                                单位职务：
                            </div>
                            <div class="col-md-2">
                                <input id="jobSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                总数：
                            </div>
                            <div class="col-md-2">
                                <input id="fundssumSel">
                            </div>
                            <div class="col-md-1 tar">
                                会费：
                            </div>
                            <div class="col-md-2">
                                <input id="membershipduesSel">
                            </div>
                            <div class="col-md-1 tar">
                                学校拨款：
                            </div>
                            <div class="col-md-2">
                                <input id="appropriatefundsSel">
                            </div>
                            <div class="col-md-1 tar">
                                留存自用的捐款：
                            </div>
                            <div class="col-md-2">
                                <input id="contributemoneySel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                其他：
                            </div>
                            <div class="col-md-2">
                                <input id="otherSel">
                            </div>
                            <div class="col-md-1 tar">
                                总数：
                            </div>
                            <div class="col-md-2">
                                <input id="contributesumSel">
                            </div>
                            <div class="col-md-1 tar">
                                上交业务主管单位：
                            </div>
                            <div class="col-md-2">
                                <input id="governingbodySel">
                            </div>
                            <div class="col-md-1 tar">
                                留存自用：
                            </div>
                            <div class="col-md-2">
                                <input id="selfpreservationSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                主要活动内容：
                            </div>
                            <div class="col-md-2">
                                <input id="activitycontentSel">
                            </div>
                            <div class="col-md-1 tar">
                                总数：
                            </div>
                            <div class="col-md-2">
                                <input id="personsumSel">
                            </div>
                            <div class="col-md-1 tar">
                                获得证书数：
                            </div>
                            <div class="col-md-2">
                                <input id="certificatenumberSel">
                            </div>
                            <div class="col-md-1 tar">
                                采集数 ：
                            </div>
                            <div class="col-md-2">
                                <input id="collectionnumberSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                配对数 ：
                            </div>
                            <div class="col-md-2">
                                <input id="pairingnumberSel">
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="save()">保存</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="del()">删除</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="content">
                    &lt;%&ndash;<div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>&ndash;%&gt;
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {



        search();
    })

    function search() {
        $.ajax({
            url:"<%=request.getContextPath()%>/redcross/selectRedCross",
            dataType:"json",
            type:"post",
            success:function (msg) {
                if (msg!=null){
                    $("#departmentSel").val(msg.department);
                    $("#communitycodeSel").val(msg.communitycode);
                    $("#communitynameSel").val(msg.communityname);
                    $("#founddateSel").val(msg.founddate);
                    $("#sumSel").val(msg.sum);
                    $("#teachingstaffnumberSel").val(msg.teachingstaffnumber);
                    $("#studentnumberSel").val(msg.studentnumber);
                    $("#moneynumSel").val(msg.moneynum);
                    $("#handinSel").val(msg.handin);
                    $("#selfSel").val(msg.self);
                    $("#nameSel").val(msg.name);
                    $("#jobSel").val(msg.job);
                    $("#fundssumSel").val(msg.fundssum);
                    $("#membershipduesSel").val(msg.membershipdues);
                    $("#appropriatefundsSel").val(msg.appropriatefunds);
                    $("#contributemoneySel").val(msg.contributemoney);
                    $("#otherSel").val(msg.other);
                    $("#contributesumSel").val(msg.contributesum);
                    $("#governingbodySel").val(msg.governingbody);
                    $("#selfpreservationSel").val(msg.selfpreservation);
                    $("#activitycontentSel").val(msg.activitycontent);
                    $("#personsumSel").val(msg.personsum);
                    $("#certificatenumberSel").val(msg.certificatenumber);
                    $("#collectionnumberSel").val(msg.collectionnumber);
                    $("#pairingnumberSel").val(msg.pairingnumber);
                    window.id = msg.id;
                }else{
                    $("#departmentSel").val("");
                    $("#communitycodeSel").val("");
                    $("#communitynameSel").val("");
                    $("#founddateSel").val("");
                    $("#sumSel").val("");
                    $("#teachingstaffnumberSel").val("");
                    $("#studentnumberSel").val("");
                    $("#moneynumSel").val("");
                    $("#handinSel").val("");
                    $("#selfSel").val("");
                    $("#nameSel").val("");
                    $("#jobSel").val("");
                    $("#fundssumSel").val("");
                    $("#membershipduesSel").val("");
                    $("#appropriatefundsSel").val("");
                    $("#contributemoneySel").val("");
                    $("#otherSel").val("");
                    $("#contributesumSel").val("");
                    $("#governingbodySel").val("");
                    $("#selfpreservationSel").val("");
                    $("#activitycontentSel").val("");
                    $("#personsumSel").val("");
                    $("#certificatenumberSel").val("");
                    $("#collectionnumberSel").val("");
                    $("#pairingnumberSel").val("");
                    window.id = "";
                }

            }
        })
    }

    function save() {
        if ($("#departmentSel").val() == "" || $("#departmentSel").val() == undefined || $("#departmentSel").val() == null) {
            swal({
                title: "请填写学校分管部门！",
                type: "warning"
            });
            return;
        }
        if ($("#communitycodeSel").val() == "" || $("#communitycodeSel").val() == undefined || $("#communitycodeSel").val() == null) {
            swal({
                title: "请填写社团代码！",
                type: "warning"
            });
            return;
        }
        if ($("#communitynameSel").val() == "" || $("#communitynameSel").val() == undefined || $("#communitynameSel").val() == null) {
            swal({
                title: "请填写社团名称！",
                type: "warning"
            });
            return;
        }
        if ($("#founddateSel").val() == "" || $("#founddateSel").val() == undefined || $("#founddateSel").val() == null) {
            swal({
                title: "请填写成立日期！",
                type: "warning"
            });
            return;
        }
        if ($("#sumSel").val() == "" || $("#sumSel").val() == undefined || $("#sumSel").val() == null) {
            swal({
                title: "请填写总数！",
                type: "warning"
            });
            return;
        }
        if ($("#teachingstaffnumberSel").val() == "" || $("#teachingstaffnumberSel").val() == undefined || $("#teachingstaffnumberSel").val() == null) {
            swal({
                title: "请填写教工数！",
                type: "warning"
            });
            return;
        }
        if ($("#studentnumberSel").val() == "" || $("#studentnumberSel").val() == undefined || $("#studentnumberSel").val() == null) {
            swal({
                title: "请填写学生数！",
                type: "warning"
            });
            return;
        }
        if ($("#moneynumSel").val() == "" || $("#moneynumSel").val() == undefined || $("#moneynumSel").val() == null) {
            swal({
                title: "请填写总数！",
                type: "warning"
            });
            return;
        }
        if ($("#handinSel").val() == "" || $("#handinSel").val() == undefined || $("#handinSel").val() == null) {
            swal({
                title: "请填写上交！",
                type: "warning"
            });
            return;
        }
        if ($("#selfSel").val() == "" || $("#selfSel").val() == undefined || $("#selfSel").val() == null) {
            swal({
                title: "请填写留存自用！",
                type: "warning"
            });
            return;
        }
        if ($("#nameSel").val() == "" || $("#nameSel").val() == undefined || $("#nameSel").val() == null) {
            swal({
                title: "请填写姓名！",
                type: "warning"
            });
            return;
        }
        if ($("#jobSel").val() == "" || $("#jobSel").val() == undefined || $("#jobSel").val() == null) {
            swal({
                title: "请填写单位职务！",
                type: "warning"
            });
            return;
        }
        if ($("#fundssumSel").val() == "" || $("#fundssumSel").val() == undefined || $("#fundssumSel").val() == null) {
            swal({
                title: "请填写总数！",
                type: "warning"
            });
            return;
        }
        if ($("#membershipduesSel").val() == "" || $("#membershipduesSel").val() == undefined || $("#membershipduesSel").val() == null) {
            swal({
                title: "请填写会费！",
                type: "warning"
            });
            return;
        }
        if ($("#appropriatefundsSel").val() == "" || $("#appropriatefundsSel").val() == undefined || $("#appropriatefundsSel").val() == null) {
            swal({
                title: "请填写学校拨款！",
                type: "warning"
            });
            return;
        }
        if ($("#contributemoneySel").val() == "" || $("#contributemoneySel").val() == undefined || $("#contributemoneySel").val() == null) {
            swal({
                title: "请填写留存自用的捐款！",
                type: "warning"
            });
            return;
        }
        if ($("#otherSel").val() == "" || $("#otherSel").val() == undefined || $("#otherSel").val() == null) {
            swal({
                title: "请填写其他！",
                type: "warning"
            });
            return;
        }
        if ($("#contributesumSel").val() == "" || $("#contributesumSel").val() == undefined || $("#contributesumSel").val() == null) {
            swal({
                title: "请填写总数！",
                type: "warning"
            });
            return;
        }
        if ($("#governingbodySel").val() == "" || $("#governingbodySel").val() == undefined || $("#governingbodySel").val() == null) {
            swal({
                title: "请填写上交业务主管单位！",
                type: "warning"
            });
            return;
        }
        if ($("#selfpreservationSel").val() == "" || $("#selfpreservationSel").val() == undefined || $("#selfpreservationSel").val() == null) {
            swal({
                title: "请填写留存自用！",
                type: "warning"
            });
            return;
        }
        if ($("#activitycontentSel").val() == "" || $("#activitycontentSel").val() == undefined || $("#activitycontentSel").val() == null) {
            swal({
                title: "请填写主要活动内容！",
                type: "warning"
            });
            return;
        }
        if ($("#personsumSel").val() == "" || $("#personsumSel").val() == undefined || $("#personsumSel").val() == null) {
            swal({
                title: "请填写总数！",
                type: "warning"
            });
            return;
        }
        if ($("#certificatenumberSel").val() == "" || $("#certificatenumberSel").val() == undefined || $("#certificatenumberSel").val() == null) {
            swal({
                title: "请填写获得证书数！",
                type: "warning"
            });
            return;
        }
        if ($("#collectionnumberSel").val() == "" || $("#collectionnumberSel").val() == undefined || $("#collectionnumberSel").val() == null) {
            swal({
                title: "请填写采集数 ！",
                type: "warning"
            });
            return;
        }
        if ($("#pairingnumberSel").val() == "" || $("#pairingnumberSel").val() == undefined || $("#pairingnumberSel").val() == null) {
            swal({
                title: "请填写配对数 ！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/redcross/saveRedCross", {
            id: window.id,
            department: $("#departmentSel").val(),
            communitycode: $("#communitycodeSel").val(),
            communityname: $("#communitynameSel").val(),
            founddate: $("#founddateSel").val(),
            sum: $("#sumSel").val(),
            teachingstaffnumber: $("#teachingstaffnumberSel").val(),
            studentnumber: $("#studentnumberSel").val(),
            moneynum: $("#moneynumSel").val(),
            handin: $("#handinSel").val(),
            self: $("#selfSel").val(),
            name: $("#nameSel").val(),
            job: $("#jobSel").val(),
            fundssum: $("#fundssumSel").val(),
            membershipdues: $("#membershipduesSel").val(),
            appropriatefunds: $("#appropriatefundsSel").val(),
            contributemoney: $("#contributemoneySel").val(),
            other: $("#otherSel").val(),
            contributesum: $("#contributesumSel").val(),
            governingbody: $("#governingbodySel").val(),
            selfpreservation: $("#selfpreservationSel").val(),
            activitycontent: $("#activitycontentSel").val(),
            personsum: $("#personsumSel").val(),
            certificatenumber: $("#certificatenumberSel").val(),
            collectionnumber: $("#collectionnumberSel").val(),
            pairingnumber: $("#pairingnumberSel").val(),
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                /*$("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();*/
                $("#dialog").load("<%=request.getContextPath()%>/redcross/toRedCrossList")
            });
        })
    }
   /* function search() {
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/redcross/getRedCrossList',
                "data": {
                    department: $("#departmentSel").val(),
                    communitycode: $("#communitycodeSel").val(),
                    communityname: $("#communitynameSel").val(),
                    founddate: $("#founddateSel").val(),
                    sum: $("#sumSel").val(),
                    teachingstaffnumber: $("#teachingstaffnumberSel").val(),
                    studentnumber: $("#studentnumberSel").val(),
                    moneynum: $("#moneynumSel").val(),
                    handin: $("#handinSel").val(),
                    self: $("#selfSel").val(),
                    name: $("#nameSel").val(),
                    job: $("#jobSel").val(),
                    fundssum: $("#fundssumSel").val(),
                    membershipdues: $("#membershipduesSel").val(),
                    appropriatefunds: $("#appropriatefundsSel").val(),
                    contributemoney: $("#contributemoneySel").val(),
                    other: $("#otherSel").val(),
                    contributesum: $("#contributesumSel").val(),
                    governingbody: $("#governingbodySel").val(),
                    selfpreservation: $("#selfpreservationSel").val(),
                    activitycontent: $("#activitycontentSel").val(),
                    personsum: $("#personsumSel").val(),
                    certificatenumber: $("#certificatenumberSel").val(),
                    collectionnumber: $("#collectionnumberSel").val(),
                    pairingnumber: $("#pairingnumberSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "department", "title": "学校分管部门"},
                 {"data": "communitycode", "title": "社团代码"},
                 {"data": "communityname", "title": "社团名称"},
                 {"data": "founddate", "title": "成立日期"},
                 {"data": "sum", "title": "总数"},
                 {"data": "teachingstaffnumber", "title": "教工数"},
                 {"data": "studentnumber", "title": "学生数"},
                 {"data": "moneynum", "title": "总数"},
                 {"data": "handin", "title": "上交"},
                 {"data": "self", "title": "留存自用"},
                 {"data": "name", "title": "姓名"},
                 {"data": "job", "title": "单位职务"},
                 {"data": "fundssum", "title": "总数"},
                 {"data": "membershipdues", "title": "会费"},
                 {"data": "appropriatefunds", "title": "学校拨款"},
                 {"data": "contributemoney", "title": "留存自用的捐款"},
                 {"data": "other", "title": "其他"},
                 {"data": "contributesum", "title": "总数"},
                 {"data": "governingbody", "title": "上交业务主管单位"},
                 {"data": "selfpreservation", "title": "留存自用"},
                 {"data": "activitycontent", "title": "主要活动内容"},
                 {"data": "personsum", "title": "总数"},
                 {"data": "certificatenumber", "title": "获得证书数"},
                 {"data": "collectionnumber", "title": "采集数 "},
                 {"data": "pairingnumber", "title": "配对数 "},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            paging: true,
            language: language
        });
    }*/

    /*function searchClear() {
        $(".form-row div input,.form-row div select").val("");
        search();
    }*/

  /*  function add() {
        $("#dialog").load("<%=request.getContextPath()%>/redcross/toRedCrossAdd")
        $("#dialog").modal("show")
    }*/

    /*function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/redcross/toRedCrossEdit?id=" + id)
        $("#dialog").modal("show")
    }*/

    function del() {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/redcross/delRedCross?id=" + window.id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    /*$('#div').reload();*/
                   /*window.location.reload();*/
                    $("#dialog").load("<%=request.getContextPath()%>/redcross/toRedCrossList")
                });
            })
        });
    }
</script>