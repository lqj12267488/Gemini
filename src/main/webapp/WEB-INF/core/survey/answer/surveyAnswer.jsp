<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <header class="mui-bar mui-bar-nav">
                        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
                        <header>投票问卷填写</header>
                    </header>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <div class="form-row" style="text-align: center"><h1 class="mui-title"> ${data.surveyTitle}</h1></div>
                    <div class="form-row">
                        <div class="col-md-12"> &nbsp;&nbsp;开始时间：${data.startTime} &nbsp;&nbsp;结束时间：${data.endTime} &nbsp;&nbsp;</div>
                    </div>
                    <div class="form-row">
                        <table class="table table-bordered table-striped table-hover text-center" >
                            <c:forEach items="${questionList}" var="questionItem">
                                <tr>
                                    <td>
                                        <div class="form-row">
                                            <div class="col-md-4">
                                                    ${questionItem.questionOrder}.${questionItem.questionName}
                                            </div>
                                            <div class="col-md-8" style="text-align:left;">
                                                <c:choose>
                                                    <c:when test="${questionItem.questionType == '1' }">
                                                        <input name="${questionItem.questionId}" type="text">
                                                    </c:when>
                                                    <c:when test="${questionItem.questionType == '2' }">
                                                        <c:forEach items="${questionItem.optionList}" var="option">
                                                            <div class="radiobox-inline">
                                                                <label>
                                                                    <input style="width: 19px;height: 19px;" type="radio" name="${questionItem.questionId}" value="${option.optionId}">
                                                                        ${option.optionValue}
                                                                </label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:when test="${questionItem.questionType == '3' }">
                                                        <c:forEach items="${questionItem.optionList}" var="option">
                                                            <div class="checkbox-inline">
                                                                <label>
                                                                    <input style="width: 19px;height: 19px;" type="checkbox" name="${questionItem.questionId}" value="${option.optionId}">
                                                                        ${option.optionValue}
                                                                </label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:when test="${questionItem.questionType == '4' }">
                                                        <c:forEach items="${questionItem.optionList}" var="option">
                                                            <div class="radiobox-inline">
                                                                <label>
                                                                    <input style="width: 19px;height: 19px;" type="radio" name="${questionItem.questionId}" value="${option.optionCode}">
                                                                        ${option.optionValue}
                                                                </label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:when test="${questionItem.questionType == '5' }">
                                                        <c:forEach items="${questionItem.optionList}" var="option">
                                                            <div class="checkbox-inline" >
                                                                <label>
                                                                    <input style="width: 19px;height: 19px;" type="checkbox" name="${questionItem.questionId}" value="${option.optionCode}">
                                                                        ${option.optionValue}
                                                                </label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                    <div class="form-row tar">
                        <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="surveyId" hidden value="${surveyId}">
</div>
<script>
    $(document).ready(function (){

    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/survey/answer/toSurveyAnswerList");
    }

    function save() {
        var indexIdVale=new Array();
        var indexNameVale=new Array();
        var indexTypeVale=new Array();


        var questionList = JSON.parse('${qList}');

        $.each(questionList, function (key, map) {
            indexIdVale.push( map.questionId );
            indexNameVale.push( map.questionName );
            indexTypeVale.push( map.questionType);
        })

        var check = false;

        var al="";
        var returnValue ="";
        for(var i=0;i<indexIdVale.length;i++){
            if(returnValue!=""){
                returnValue += "@@@@";
            }
            var id = indexIdVale[i];
            if(indexTypeVale[i] == 1){
                if($('input[name='+id+']').val() == ""){
                    al="请填写问题 "+indexNameVale[i];
                    check = true;
                    i = indexIdVale.length+1;
                }else{
                    returnValue += indexIdVale[i]+"##"+$('input[name='+id+']').val();
                }
            }else if( indexTypeVale[i] == 2 || indexTypeVale[i] == 3 ){
                var b = true  ;
                var remark = "";
                $('input[name='+id+']:checked').each(function(){
                    b = false;
                    if(remark != ""){
                        remark += ',';
                    }
                    remark += $(this).val();
                });
                if(b){
                    al="请选择问题 "+indexNameVale[i]+" 的答案";
                    check = true;
                    i = indexIdVale.length+1;
                }else{
                    returnValue += indexIdVale[i]+"##"+remark;
                }
            }else if( indexTypeVale[i] == 4 || indexTypeVale[i] == 5 ){
                var b = true  ;
                var remark = "";
                $('input[name='+id+']:checked').each(function(){
                    b = false;
                    if(remark != ""){
                        remark += ',';
                    }
                    var r = $(this).val().split(",");
                    remark += r[0];
                });
                if(b){
                    al="请选择问题 "+indexNameVale[i]+" 的答案";
                    check = true;
                    i = indexIdVale.length+1;
                }else{
                    returnValue += indexIdVale[i]+"##"+remark;
                }
            }
        }
        if(check ){
            swal({title: al, type: "info"});
            return;
        }

        insertResult(returnValue);
        indexIdVale=new Array();
        indexTypeVale=new Array();
        indexNameVale=new Array();
        $('.modal-dialog').css('opacity','');
        $("#layout").css('display','block');
    }

    function insertResult(returnValue){
        $('.loading').css('background-color','rgba(174, 173, 173, 0.4)');
        $("#layout").css('display','block');
        $('#saveBtn').attr('disabled',"disabled");
        $('#closeBtn').attr('disabled',"disabled");

        $.post("<%=request.getContextPath()%>/survey/answer/saveSurveyAnswer",
            {
                answerResult:returnValue,
                surveyId:$("#surveyId").val(),
            },
            function (msg) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal("hide");
                back();
            })
    }


</script>