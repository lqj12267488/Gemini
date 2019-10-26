<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="form-row">
    <div class="col-md-11 wrapLf" style="padding-left: 3%;">
        <div class="col-md-3 tar addWdlf" style="float: left;">
            申请时间
        </div>
        <div class="col-md-9 addWdrt" style="margin-bottom: 10px">
            <input id="f_requestDate" type="datetime-local" readonly="readonly"
                   class="validate[required,maxSize[100]] form-control"
                   value="${studentReissue.requestDate}"/>
        </div>
        <div class="col-md-3 tar addWdlf" style="float: left;">
            学生姓名
        </div>
        <div class="col-md-9 addWdrt" style="margin-bottom: 10px">
            <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
                   value="${studentReissue.studentId}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar addWdlf" style="float: left;">
            民族
        </div>
        <div class="col-md-9 addWdrt" style="margin-bottom: 10px">
            <input id="f_nation" type="text" class="validate[required,maxSize[100]] form-control"
                   value="${studentReissue.nation}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar addWdlf" style="float: left;">
            性别
        </div>
        <div class="col-md-9 addWdrt" style="margin-bottom: 10px">
            <input id="f_sex" type="text" class="validate[required,maxSize[100]] form-control"
                   value="${studentReissue.sex}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar addWdlf" style="float: left;">
            班级
        </div>
        <div class="col-md-9 addWdrt">
            <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
                   value="${studentReissue.classId}" readonly="readonly"/>
        </div>
    </div>
    <div class="col-md-1 wrapRt" style="padding-left: 0;">
        <div style="width:100%;">
            <img onclick="showInputFileImg(this.src)"
                 style="width:100%;height: 189px; cursor:pointer;"
                 src="data:image/png;base64,${studentReissue.img}"
                 height="150"
                 width="110" alt="" id="userImg1">
        </div>
    </div>
</div>
<%--<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.requestDate}"/>
    </div>
</div>--%>
<%--<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.studentId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        民族
    </div>
    <div class="col-md-9">
        <input id="f_nation" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.nation}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        性别
    </div>
    <div class="col-md-9">
        <input id="f_sex" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.sex}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.classId}" readonly="readonly"/>
    </div>
</div>--%>
<div class="form-row">
    <div class="col-md-3 tar">
        专业
    </div>
    <div class="col-md-9">
        <input id="majorCode" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentReissue.majorCode}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学号
    </div>
    <div class="col-md-9">
        <input id="studentNumber" type="text" readonly="readonly"
               value="${studentReissue.studentNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        身份证号
    </div>
    <div class="col-md-9">
        <input id="f_idcard" type="text"  readonly="readonly" value="${studentReissue.idcard}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        乘车区间
    </div>
    <div class="col-md-9">
        <input id="f_rideZone" readonly="readonly"value="${studentReissue.rideZone}"></input>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        家庭地址
    </div>
    <div class="col-md-9">
        <input id="f_familyAddress"  readonly="readonly"value="${studentReissue.familyAddress}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        新疆省
    </div>
    <div class="col-md-9">
        <input id="f_xinjiangProvinc"  readonly="readonly" value="${studentReissue.province}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        地区（州）
    </div>
    <div class="col-md-9">
        <input id="f_regional"  readonly="readonly" value="${studentReissue.regional}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        市（县）
    </div>
    <div class="col-md-9">
        <input id="f_city" readonly="readonly" value="${studentReissue.city}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请项目
    </div>
    <div class="col-md-9">
        <input id="f_requestProject"  readonly="readonly" value="${studentReissue.requestProject}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请理由
    </div>
    <div class="col-md-9">
        <input id="f_requestReason"  readonly="readonly" value="${studentReissue.requestReason}"/>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/studentReissue/printStudentReissue?id=${studentReissue.id}">
<style>
@media (max-width:1367px){
.wrapLf {
width: 87%;
}
.wrapRt {
width: 13%;
}
.addWdlf {
width: 26.2%;
}
.addWdrt {
width: 73.8%;
}
}
</style>
<script>
    //下载图片
    function showInputFileImg(imgUrl) {
        // 这里是获取到的图片base64编码,这里只是个例子哈，要自行编码图片替换这里才能测试看到效果
        //const imgUrl = 'data:image/png;base64,...'
        // 如果浏览器支持msSaveOrOpenBlob方法（也就是使用IE浏览器的时候），那么调用该方法去下载图片
        if (window.navigator.msSaveOrOpenBlob) {
            var bstr = atob(imgUrl.split(',')[1])
            var n = bstr.length
            var u8arr = new Uint8Array(n)
            while (n--) {
                u8arr[n] = bstr.charCodeAt(n)
            }
            var blob = new Blob([u8arr])
            window.navigator.msSaveOrOpenBlob(blob, '${studentReissue.studentId}' + '.' + 'png')
        } else {
            // 这里就按照chrome等新版浏览器来处理
            const a = document.createElement('a')
            a.href = imgUrl
            a.setAttribute('download', '${studentReissue.studentId}')
            a.click()
        }
    }
</script>

