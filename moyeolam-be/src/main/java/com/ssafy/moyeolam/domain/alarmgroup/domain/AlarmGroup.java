package com.ssafy.moyeolam.domain.alarmgroup.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.meta.converter.AlarmMissionConverter;
import com.ssafy.moyeolam.domain.meta.converter.AlarmSoundConverter;
import com.ssafy.moyeolam.domain.meta.domain.MetaData;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Entity(name = "alarm_group")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AlarmGroup extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "alarm_group_id")
    private Long id;

    @Column
    private String title;

    @Column
    private LocalTime time;

    @Builder.Default
    @Column
    private Boolean repeat = Boolean.FALSE;

    @Builder.Default
    @Column
    private Boolean lock = Boolean.FALSE;

    @Convert(converter = AlarmMissionConverter.class)
    private MetaData alarmMission;

    @Convert(converter = AlarmSoundConverter.class)
    private MetaData alarmSound;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member hostMember;

    @OneToMany(mappedBy = "alarmGroup")
    private List<AlarmDay> alarmDays = new ArrayList<>();

    @OneToMany(mappedBy = "alarmGroup")
    private List<AlarmGroupMember> alarmGroupMembers = new ArrayList<>();

    public void updateAlarmGroup(String title, LocalTime time) {
        this.title = title;
        this.time = time;
    }

    public void setAlarmMission(MetaData alarmMission) {
        this.alarmMission = alarmMission;
    }

    public void setAlarmSound(MetaData alarmSound) {
        this.alarmSound = alarmSound;
    }

    public void setLock(Boolean lock) {
        this.lock = lock;
    }
}
