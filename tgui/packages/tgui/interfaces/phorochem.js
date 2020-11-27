import { Box, Button, Flex, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { round } from 'common/math';

export const Phorochem = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    intensity,
    phoron,
    message,
    timeLeft,
    timeLeftMax,
  } = data;
  return (
    <Window
      width={425}
      height={270}
      resizable>
      <Window.Content>
        <Section title="Phorochemistry Control">
          <LabeledList>
            <LabeledList.Item label="Commands">
              <Button
                content="Recalibrate"
                onClick={() => act('recalibrate')} />
              <Button
                content="Begin Test"
                onClick={() => act('beginTest')} />
              <Button
                content="Abort Test"
                onClick={() => act('abortTest')} />
            </LabeledList.Item>
            <LabeledList.Item label="Intensity">
              <Button
                content="1"
                disabled={intensity === 1}
                onClick={() => act('1', {
                  intensity: '1',
                })} />
              <Button
                content="2"
                disabled={intensity === 2}
                onClick={() => act('intensity', {
                  intensity: '2',
                })} />
              <Button
                content="3"
                disabled={intensity === 3}
                onClick={() => act('intensity', {
                  intensity: '3',
                })} />
              <Button
                content="4"
                disabled={intensity === 4}
                onClick={() => act('intensity', {
                  intensity: '4',
                })} />
              <Button
                content="5"
                disabled={intensity === 5}
                onClick={() => act('intensity', {
                  intensity: '5',
                })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Information">
          <LabeledList>
            <LabeledList.Item label="Phoron">
              <ProgressBar
                value={phoron}
                ranges={{
                  good: [0.35, Infinity],
                  average: [0.15, 0.35],
                  bad: [-Infinity, 0.15],
                }}>
                {phoron + ' Moles'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Progress">
              <ProgressBar
                value={timeLeft}
                ranges={{
                }}>
                {timeLeft + '%'}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
          <Section>
            {message}
          </Section>
        </Section>
      </Window.Content>
    </Window>
  );
};
