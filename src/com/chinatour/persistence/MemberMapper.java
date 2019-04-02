package com.chinatour.persistence;

import com.chinatour.entity.Member;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Dao - 会员
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Repository
public interface MemberMapper extends BaseMapper<Member, String> {

    /**
     * 判断用户名是否存在
     *
     * @param username 用户名(忽略大小写)
     * @return 用户名是否存在
     */
    boolean usernameExists(String username);

    /**
     * 判断E-mail是否存在
     *
     * @param email E-mail(忽略大小写)
     * @return E-mail是否存在
     */
    boolean emailExists(String email);

    /**
     * 根据用户名查找会员
     *
     * @param username 用户名(忽略大小写)
     * @return 会员，若不存在则返回null
     */
    Member findByUsername(String username);

    /**
     * 根据E-mail查找会员
     *
     * @param email E-mail(忽略大小写)
     * @return 会员，若不存在则返回null
     */
    List<Member> findListByEmail(String email);

    /**
     * 查找会员消费信息
     *
     * @param beginDate 起始日期
     * @param endDate   结束日期
     * @param count     数量
     * @return 会员消费信息
     */
    List<Object[]> findPurchaseList(Date beginDate, Date endDate, Integer count);

}
