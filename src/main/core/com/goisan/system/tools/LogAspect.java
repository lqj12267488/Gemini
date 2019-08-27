package com.goisan.system.tools;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.*;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.Arrays;

/**
 * Created by Administrator on 2017/8/29.
 */
@Aspect
@Component
@Order(1)
public class LogAspect {
    /**
     * try{
     *      @Before前置通知
     *      method.invoke();
     *      @AfterRunning返回通知
     * }catch(e){
     *      @AfterThrowing：异常通知，
     * }
     * @After
     *
     * 告诉Spring这些放在都在那个方法的哪个位置执行
     * 1）、告诉位置
    [1]@Before：前置通知，在方法执行之前执行
    [2]@After：后置通知，在方法执行最终结束之后执行。
    如果没异常
    [3]@AfterRunning：返回通知，在方法返回结果之后执行
    [4]@AfterThrowing：异常通知，在方法抛出异常之后执行


    1、编写切入点表达式，来告诉spring是切入哪个方法的这个位置
     */
    @Pointcut(value = "execution(public * com.goisan.*.*.service.impl.*.*(..))")
    //@Pointcut(value = "execution(public * *.*(int,int))")
    public void mypoint() {
    }

    @Before(value="mypoint()")
    public void logStart(JoinPoint joinPoint){
        Object[] args = joinPoint.getArgs();
        String name = joinPoint.getSignature().getName();
        System.out.println("AOP日志：【" + name + "】方法开始运行,参数是:"
                + Arrays.asList(args));
    }

    @After("mypoint()")
    public void logEnd(JoinPoint joinPoint){
        String name = joinPoint.getSignature().getName();
        System.out.println("AOP日志：【" + name + "】方法运行结束!");
    }

    @AfterThrowing(value="execution(public * *.*(int, int))", throwing = "abc")
    public void logException(JoinPoint joinPoint, Throwable abc){
        // 获取方法名
        String name = joinPoint.getSignature().getName();
        System.out.println("AOP日志，【" + name + "】方法出现异常：异常对象：" + abc);
    }

    @AfterReturning(value="execution(public * *.*(int, int))",returning = "res")
    public void logReturn(JoinPoint joinPoint, Object res){
        Signature signature = joinPoint.getSignature();
        String name = signature.getName();
        System.out.println("AOP日志，方法正常执行");
        System.out.println("AOP参数验证，【" + name + "】方法正常返回,返回值为：" + res);
    }
}
