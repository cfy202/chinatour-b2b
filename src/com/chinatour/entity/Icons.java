package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Created by XuXuebin on 2014-08-29.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Icons extends BaseUuidEntity {

    private String name;

    private String type;

    private String url;
}
