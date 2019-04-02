/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.entity;

import com.chinatour.util.FreemarkerUtils;
import freemarker.template.TemplateException;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.nodes.TextNode;

import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Entity - 文章
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Article extends BaseEntity {

    private static final long serialVersionUID = 1475773294701585482L;

    /**
     * 点击数缓存名称
     */
    public static final String HITS_CACHE_NAME = "articleHits";

    /**
     * 点击数缓存更新间隔时间
     */
    public static final int HITS_CACHE_INTERVAL = 600000;

    /**
     * 内容分页长度
     */
    private static final int PAGE_CONTENT_LENGTH = 800;

    /**
     * 内容分页符
     */
    private static final String PAGE_BREAK_SEPARATOR = "<hr class=\"pageBreak\" />";

    /**
     * 段落分隔符配比
     */
    private static final Pattern PARAGRAPH_SEPARATOR_PATTERN = Pattern.compile("[,;\\.!?，；。！？]");

    /**
     * 静态路径
     */
    private static String staticPath;

    /**
     * 标题
     */
    private String title;

    /**
     * 作者
     */
    private String author;

    /**
     * 内容
     */
    private String content;

    /**
     * 页面标题
     */
    private String seoTitle;

    /**
     * 页面关键词
     */
    private String seoKeywords;

    /**
     * 页面描述
     */
    private String seoDescription;

    /**
     * 是否发布
     */
    private Boolean isPublication;

    /**
     * 是否置顶
     */
    private Boolean isTop;

    /**
     * 点击数
     */
    private Long hits;

    /**
     * 页码
     */
    private Integer pageNumber;

    /**
     * 文章分类
     */
    private ArticleCategory articleCategory;

    /**
     * 标签
     */
    private Set<Tag> tags = new HashSet<Tag>();

    /**
     * 获取访问路径
     *
     * @return 访问路径
     */
    public String getPath() {
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("id", getId());
        model.put("createDate", getCreateDate());
        model.put("modifyDate", getModifyDate());
        model.put("title", getTitle());
        model.put("seoTitle", getSeoTitle());
        model.put("seoKeywords", getSeoKeywords());
        model.put("seoDescription", getSeoDescription());
        model.put("pageNumber", getPageNumber());
        try {
            return FreemarkerUtils.process(staticPath, model);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取文本内容
     *
     * @return 文本内容
     */
    public String getText() {
        if (getContent() != null) {
            return Jsoup.parse(getContent()).text();
        }
        return null;
    }

    /**
     * 获取分页内容
     *
     * @return 分页内容
     */
    public String[] getPageContents() {
        if (StringUtils.isEmpty(content)) {
            return new String[]{""};
        }
        if (content.contains(PAGE_BREAK_SEPARATOR)) {
            return content.split(PAGE_BREAK_SEPARATOR);
        } else {
            List<String> pageContents = new ArrayList<String>();
            Document document = Jsoup.parse(content);
            List<Node> children = document.body().childNodes();
            if (children != null) {
                int textLength = 0;
                StringBuffer html = new StringBuffer();
                for (Node node : children) {
                    if (node instanceof Element) {
                        Element element = (Element) node;
                        html.append(element.outerHtml());
                        textLength += element.text().length();
                        if (textLength >= PAGE_CONTENT_LENGTH) {
                            pageContents.add(html.toString());
                            textLength = 0;
                            html.setLength(0);
                        }
                    } else if (node instanceof TextNode) {
                        TextNode textNode = (TextNode) node;
                        String text = textNode.text();
                        String[] contents = PARAGRAPH_SEPARATOR_PATTERN.split(text);
                        Matcher matcher = PARAGRAPH_SEPARATOR_PATTERN.matcher(text);
                        for (String content : contents) {
                            if (matcher.find()) {
                                content += matcher.group();
                            }
                            html.append(content);
                            textLength += content.length();
                            if (textLength >= PAGE_CONTENT_LENGTH) {
                                pageContents.add(html.toString());
                                textLength = 0;
                                html.setLength(0);
                            }
                        }
                    }
                }
                String pageContent = html.toString();
                if (StringUtils.isNotEmpty(pageContent)) {
                    pageContents.add(pageContent);
                }
            }
            return pageContents.toArray(new String[pageContents.size()]);
        }
    }

    /**
     * 获取总页数
     *
     * @return 总页数
     */
    public int getTotalPages() {
        return getPageContents().length;
    }

}