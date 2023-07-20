package com.ssafy.moyeolam.domain.member.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.meta.converter.AlertTypeConverter;
import com.ssafy.moyeolam.domain.meta.domain.AlertType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name = "alert_log")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AlertLog extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "alert_log_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "from_member_id", referencedColumnName = "member_id")
    private Member fromMember;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "to_member_id", referencedColumnName = "member_id")
    private Member toMember;

    @Convert(converter = AlertTypeConverter.class)
    private AlertType alertType;

    @Builder.Default
    @Column
    private Boolean alertCheck = Boolean.FALSE;
}
