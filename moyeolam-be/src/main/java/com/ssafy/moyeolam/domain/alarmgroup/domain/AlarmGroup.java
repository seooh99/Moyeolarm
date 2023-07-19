package com.ssafy.moyeolam.domain.alarmgroup.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.meta.converter.AlarmSoundConverter;
import com.ssafy.moyeolam.domain.meta.domain.AlarmMission;
import com.ssafy.moyeolam.domain.meta.domain.AlarmSound;
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
    private LocalTime time;

    @Builder.Default
    @Column
    private Boolean repeat = Boolean.FALSE;

    @Builder.Default
    @Column
    private Boolean lock = Boolean.FALSE;

    @Convert(converter = AlarmMission.class)
    private MetaData alarmMission;

    @Convert(converter = AlarmSoundConverter.class)
    private MetaData alarmSound;

    @OneToMany(mappedBy = "alarm_group")
    private List<AlarmDay> alarmDays = new ArrayList<>();

    @OneToMany(mappedBy = "alarm_group")
    private List<AlarmGroupMember> alarmGroupMembers = new ArrayList<>();
}
