/**
 * Created by admin on 2017/10/12.
 */
function downResourceFiles(resourceId,fileUrl,fileName,url) {
    window.location.href=url+"/resourcePublic/downResource?resourceId="+resourceId
        +"&fileUrl="+fileUrl+"&fileName="+fileName;
}
function collectionResourceFiles(resourceId,collection,url) {
    $.get(url+"/resourceLibrary/collection/saveResourceCollection?resourceId="+resourceId+"&validFlag="+collection, function (data) {
        swal({title: data.msg, type: data.result});
        $("#centent_zy_left").load(url+"/resourcePublic/getPublicResourceView?resourceId="+resourceId);
    })
}

function selectResourceAbout(resourceCourseId,url) {
    $.get(url+"/IndexSearch/SearchResource?endCount=8&resourceCourseId="+resourceCourseId, function (data) {
        var listhtml ="";
        $.each(data.listData, function (index, content) {
            listhtml = '<li><a target="_blank" ' +
                'href='+url+'"/resourcePublic/getPublicResourceViewMain?resourceId='+content.resourceId
                +'&publicPersonId='+content.publicPersonId+'">'+content.resourceName+'</a></li>'+listhtml;
        })
        $("#courseAbouthtml").html(listhtml);

    })

}