package net.ussoft.zhxh.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.Table;

import org.springframework.core.annotation.AnnotationUtils;

import java.util.Set;

public class MakeQuerySql {
	
	public static <T> Map<String, Object> search(Class<T> typeClass,Map<String, Object> map){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Table table = AnnotationUtils.findAnnotation(typeClass, Table.class);
		if(table==null){
			throw new RuntimeException(typeClass+"没有定义@table");
		}
		String tableName = table.name();
		
//		String tablename = typeClass.getName().substring(
//                typeClass.getName().lastIndexOf(".") + 1);
		
		StringBuffer sql=new StringBuffer("select * from ");
        sql.append(tableName);
        if (map.size()!=0) {
            sql.append(" t where 1=1");//后面只需拼接and条件
        }
        List<Object> values = new ArrayList<Object>();
        
        Set<Entry<String, Object>> set=map.entrySet();
        Iterator iterator=set.iterator();
        for (int i = 0; i < set.size(); i++) {
            Map.Entry mapEntry=(Entry) iterator.next();
            if (null != mapEntry.getValue() && !"".equals(mapEntry.getValue().toString())) {
            	sql.append(" and t."+mapEntry.getKey()+" ?");
            	values.add(mapEntry.getValue());
            }
        }
        resultMap.put("sql", sql.toString());
        resultMap.put("values", values);
        return resultMap;
	}
	
	public static <T> Map<String, Object> search_like(Class<T> typeClass,Map<String, Object> map){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Table table = AnnotationUtils.findAnnotation(typeClass, Table.class);
		if(table==null){
			throw new RuntimeException(typeClass+"没有定义@table");
		}
		String tableName = table.name();
		
//		String tablename = typeClass.getName().substring(
//                typeClass.getName().lastIndexOf(".") + 1);
		
		StringBuffer sql=new StringBuffer("select * from ");
		sql.append(tableName);
		if (map.size()!=0) {
			sql.append(" t where 1=1");//后面只需拼接and条件
		}
		List<Object> values = new ArrayList<Object>();
		
		Set<Entry<String, Object>> set=map.entrySet();
		Iterator iterator=set.iterator();
		for (int i = 0; i < set.size(); i++) {
			Map.Entry mapEntry=(Entry) iterator.next();
			if (null != mapEntry.getValue() && !"".equals(mapEntry.getValue().toString())) {
//				sql.append(" and t."+mapEntry.getKey()+" ?");
				sql.append(" and t."+mapEntry.getKey()+" like '%?%");
				values.add(mapEntry.getValue());
			}
		}
		resultMap.put("sql", sql.toString());
		resultMap.put("values", values);
		return resultMap;
	}

	/*private static String search(Class typeClass,Map<String, Object> map){
		
		String tablename = typeClass.getName().substring(
                typeClass.getName().lastIndexOf(".") + 1);
		
		StringBuffer sql=new StringBuffer("select * from ");
        sql.append(tablename);
        if (map.size()!=0) {
            sql.append(" t where 1=1");//后面只需拼接and条件
        }
        Set<Entry<String, Object>> set=map.entrySet();
        Iterator iterator=set.iterator();
        for (int i = 0; i < set.size(); i++) {
            Map.Entry mapEntry=(Entry) iterator.next();
            if (!"".equals(mapEntry.getValue().toString())) {
                //模糊匹配
                if (mapEntry.getKey().toString().contains("like")) {
                    sql.append(" and t."+mapEntry.getKey()+" ?");
                //精确匹配
                }else {
                    sql.append(" and t."+mapEntry.getKey()+" ?");
                }
            }
        }
        return sql.toString();
	}*/
	
	public static void main(String[] args) {
		
		//无固定顺序
//		Map<String, Object> map = new HashMap<String, Object>();
		//保持添加顺序
	/*	Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("name =", "张三");
		map.put("parentid =", "123");
		map.put("mobile like", "150");
		map.put("age >=", 30);
		
        Map<String, Object> resultmap = search(Public_user.class,map);
        System.out.println(resultmap.get("sql"));*/
        
	}
}
