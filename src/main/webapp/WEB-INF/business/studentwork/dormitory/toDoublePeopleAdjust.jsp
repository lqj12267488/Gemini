<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/25
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学生姓名
                    </div>
                    <div class="col-md-9">
                        <input id="first"   placeholder="请输入学生姓名" type="text"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  学生姓名
                    </div>
                    <div class="col-md-9">
                        <input id="second"  placeholder="请输入学生姓名" type="text"  class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>



            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="doubleAdjust()">两人互调</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>


<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

        //学生甲自动完成框初始化
        $.get("<%=request.getContextPath()%>/dorm/student/autoCompleteStudentClassDorm", function (data) {
            $("#first").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#first").val(ui.item.label);
                    $("#first").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        //学生乙自动完成框初始化
        $.get("<%=request.getContextPath()%>/dorm/student/autoCompleteStudentClassDorm", function (data) {
            $("#second").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#second").val(ui.item.label);
                    $("#second").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    })


    function doubleAdjust() {
        //学生甲自动完成框
        var  firstAuto=$("#first").attr("keycode");
        var  secondAuto=$("#second").attr("keycode");
        var  firstStudent="";
        var  firstSex="";
        var  firstClass="";
        var  firstDorm="";
        var  secondStudent="";
        var  secondDorm="";
        var  secondClass="";
        var  secondSex="";
        if(firstAuto!=null){
             firstStudent=firstAuto.split(",")[0];
             firstClass=firstAuto.split(",")[1];
             firstDorm=firstAuto.split(",")[2];
             firstSex=firstAuto.split(",")[3];
        }
        if(secondAuto!=null){
            secondStudent=secondAuto.split(",")[0];
            secondClass=secondAuto.split(",")[1];
            secondDorm=secondAuto.split(",")[2];
            secondSex=secondAuto.split(",")[3];
        }
        if($("#first").val() =="" || $("#first").val() == undefined){
             swal({
                title: "请输入甲学生姓名！",
                type: "info"
            });
            return;
        }
        if($("#second").val() == "" || $("#second").val() == undefined){
             swal({
                title: "请输入乙学生姓名！",
                type: "info"
            });
            return;
        }
         if(firstStudent==secondStudent){
              swal({
                 title: "请选择不同的学生！",
                 type: "error"
             });
             return;
         }
         if(firstSex!=secondSex){
             swal({
                 title: "对不起，性别不统一！",
                 type: "error"
             });
            return;
        }
         if(firstDorm==secondDorm){
             swal({
                 title: "不支持同寝互调！",
                 type: "error"
             });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/dorm/saveDoublePerpleAdjust", {
            firstStudent: firstStudent,
            firstDorm: firstDorm,
            firstClass:firstClass,
            secondStudent: secondStudent,
            secondClass:secondClass,
            secondDorm: secondDorm
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
                $("#dialog").modal('hide');
                $('#adjustTable').DataTable().ajax.reload();

        })
    }

</script>
