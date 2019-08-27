package com.goisan.system.tools;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.poi.ss.formula.functions.T;

import java.io.IOException;

public class JsonUtils {

    private static ObjectMapper mapper;

    public static T toBean(String jsonStr, T t) {
        if (mapper == null) {
            mapper = new ObjectMapper();
        }
        try {
            return mapper.readValue(jsonStr, t.getClass());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static <T> T toBean2(String jsonStr, Class<T> type) {
        if (mapper == null) {
            mapper = new ObjectMapper();
        }
        try {
            return mapper.readValue(jsonStr, type);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String toJson(Object o) {
        if (mapper == null) {
            mapper = new ObjectMapper();
        }
        try {
            return mapper.writeValueAsString(o);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }
    
}
