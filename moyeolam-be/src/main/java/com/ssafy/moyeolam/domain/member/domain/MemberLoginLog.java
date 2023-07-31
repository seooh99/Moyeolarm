package com.ssafy.moyeolam.domain.member.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name = "member_login_log")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberLoginLog extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_login_log_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @Column
    private String remote_addr;

}
