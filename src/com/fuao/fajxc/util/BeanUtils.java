package com.fuao.fajxc.util;
import java.lang.reflect.Field;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spicefactory.lib.reflect.Bean;
import org.spicefactory.lib.reflect.Property;
import org.spicefactory.lib.reflect.ReflectionFactory;
import org.springframework.util.Assert;
import org.springframework.util.ReflectionUtils;

public class BeanUtils extends org.apache.commons.beanutils.BeanUtils{
	private static ReflectionFactory reflectionFactory = new ReflectionFactory();
    private BeanUtils()
    {
    }
    
    /**
     * 替换原来的方法??原有方法采用Introspector在Java 5??中碰到泛型（Generic）时无法获取正确

信息，因此代替??
     * @param bean
     * @param name
     * @param value
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     */
    public static void setProperty(Object bean, String name, Object value)
    throws IllegalAccessException, InvocationTargetException {

    	Bean sbean = reflectionFactory.getBean(bean.getClass());
    	Property sproperty = sbean.getProperty(name);
    	sproperty.setValue(bean, value);
    }
    static public Field getDeclaredField(Object object, String propertyName) throws 

NoSuchFieldException
    {
        Assert.notNull(object);
        Assert.hasText(propertyName);
        return getDeclaredField(object.getClass(), propertyName);
    }

    static public Field getDeclaredField(Class<?> clazz, String propertyName) throws 

NoSuchFieldException
    {
        Assert.notNull(clazz);
        Assert.hasText(propertyName);
        for(Class<?> superClass = clazz; superClass != Object.class; superClass = 

superClass.getSuperclass())
        {
            try
            {
                return superClass.getDeclaredField(propertyName);
            }
            catch(NoSuchFieldException e)
            {
                // Field不在当前类定??继续向上转型
            }
        }
        throw new NoSuchFieldException("No such field: " + clazz.getName() + '.' + 

propertyName);
    }

    static public Object forceGetProperty(Object object, String propertyName) throws 

NoSuchFieldException
    {
        Assert.notNull(object);
        Assert.hasText(propertyName);

        Field field = getDeclaredField(object, propertyName);

        boolean accessible = field.isAccessible();
        field.setAccessible(true);

        Object result = null;
        try
        {
            result = field.get(object);
        }
        catch(IllegalAccessException e)
        {
            _logger.info("error wont' happen");
        }
        field.setAccessible(accessible);
        return result;
    }

    static public void forceSetProperty(Object object, String propertyName, Object newValue) 

throws NoSuchFieldException
    {
        Assert.notNull(object);
        Assert.hasText(propertyName);

        Field field = getDeclaredField(object, propertyName);
        boolean accessible = field.isAccessible();
        field.setAccessible(true);
        try
        {
            field.set(object, newValue);
        }
        catch(IllegalAccessException e)
        {
            _logger.info("Error won't happen");
        }
        field.setAccessible(accessible);
    }

    static public Object invokePrivateMethod(Object object, String methodName, Object... 

params) throws NoSuchMethodException
    {
        Assert.notNull(object);
        Assert.hasText(methodName);
        Class[] types = new Class[params.length];
        for(int i = 0; i < params.length; i++)
        {
            types[i] = params[i].getClass();
        }

        Class<?> clazz = object.getClass();
        Method method = null;
        for(Class<?> superClass = clazz; superClass != Object.class; superClass = 

superClass.getSuperclass())
        {
            try
            {
                method = superClass.getDeclaredMethod(methodName, types);
                break;
            }
            catch(NoSuchMethodException e)
            {
                //
            }
        }

        if(method == null)
        {
            throw new NoSuchMethodException("No Such Method:" + clazz.getSimpleName() + 

methodName + params);
        }

        boolean accessible = method.isAccessible();
        method.setAccessible(true);
        Object result = null;
        try
        {
            result = method.invoke(object, params);
        }
        catch(Exception e)
        {
            ReflectionUtils.handleReflectionException(e);
        }
        method.setAccessible(accessible);
        return result;
    }

    static public List<Field> getFieldsByType(Object object, Class<?> type)
    {
        ArrayList<Field> list = new ArrayList<Field>();
        Field[] fields = object.getClass().getDeclaredFields();
        for(Field field : fields)
        {
            if(field.getType().isAssignableFrom(type))
            {
                list.add(field);
            }
        }
        return list;
    }

    public static Class<?> getPropertyType(Class<?> type, String name) throws 

SecurityException, NoSuchFieldException
    {
        return getDeclaredField(type, name).getType();
    }

    public static String getGetterName(Class<?> type, String fieldName)
    {
        Assert.notNull(type, "Type required");
        Assert.hasText(fieldName, "FieldName required");

        if(type.getName().equals("boolean"))
        {
            return "is" + StringUtils.capitalize(fieldName);
        }
        else
        {
            return "get" + StringUtils.capitalize(fieldName);
        }
    }

    public static Method getGetterMethod(Class<?> type, String fieldName)
    {
        try
        {
            return type.getMethod(getGetterName(type, fieldName));
        }
        catch(NoSuchMethodException e)
        {
            _logger.error(e.getMessage(), e);
        }
        return null;
    }

    protected static final Log _logger = LogFactory.getLog(BeanUtils.class);
}
