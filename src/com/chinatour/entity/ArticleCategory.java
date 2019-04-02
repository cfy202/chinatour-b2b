package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by XuXuebin on 2014/8/12.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ArticleCategory extends BaseEntity {

    /**
     * 树路径分隔符
     */
    public static final String TREE_PATH_SEPARATOR = ",";

    /**
     * 访问路径前缀
     */
    private static final String PATH_PREFIX = "/article/list";

    /**
     * 访问路径后缀
     */
    private static final String PATH_SUFFIX = ".jhtml";

    /**
     * 名称
     */
    private String name;

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
     * 树路径
     */
    private String treePath;

    /**
     * 层级
     */
    private Integer grade;

    /**
     * 上级分类
     */
    private ArticleCategory parent;

    /**
     * 下级分类
     */
    private Set<ArticleCategory> children = new HashSet<ArticleCategory>();

    /**
     * 文章
     */
    private Set<Article> articles = new HashSet<Article>();

    /**
     * 获取树路径
     *
     * @return 树路径
     */
    public List<Long> getTreePaths() {
        List<Long> treePaths = new ArrayList<Long>();
        String[] ids = StringUtils.split(getTreePath(), TREE_PATH_SEPARATOR);
        if (ids != null) {
            for (String id : ids) {
                treePaths.add(Long.valueOf(id));
            }
        }
        return treePaths;
    }

    /**
     * 获取访问路径
     *
     * @return 访问路径
     */
    public String getPath() {
        if (getId() != null) {
            return PATH_PREFIX + "/" + getId() + PATH_SUFFIX;
        }
        return null;
    }
}
