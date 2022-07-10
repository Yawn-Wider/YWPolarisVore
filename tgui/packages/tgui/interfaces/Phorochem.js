import { Button, LabeledList, ProgressBar, Section } from '../components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Phorochem = (props, context) => {
  const { act, data } = useBackend(context);
  const { intensity, phoron, message, timeLeft, timeLeftMax } = data;
  return (
    <Window width={425} height={270} resizable>
      <Window.Content>
        <Section title="Phorochemistry Control">
          <LabeledList>
            <LabeledList.Item label="Commands">
              <Button content="Recalibrate" onClick={() => act('recalibrate')} />
              <Button content="Begin Test" onClick={() => act('beginTest')} />
              <Button content="Abort Test" onClick={() => act('abortTest')} />
            </LabeledList.Item>
            <LabeledList.Item label="Intensity">
              <Button icon="backward" onClick={() => act('remove_intensity')} />
              <Button content="1" disabled={intensity !== 1} selected={intensity === 1} />
              <Button content="2" disabled={intensity !== 2} selected={intensity === 2} />
              <Button content="3" disabled={intensity !== 3} selected={intensity === 3} />
              <Button content="4" disabled={intensity !== 4} selected={intensity === 4} />
              <Button content="5" disabled={intensity !== 5} selected={intensity === 5} />
              <Button icon="forward" onClick={() => act('add_intensity')} />
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
              <ProgressBar value={timeLeft} maxValue={timeLeftMax} ranges={{}}>
                {timeLeft + '/' + timeLeftMax + ' Seconds'}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
          <Section>{message}</Section>
        </Section>
      </Window.Content>
    </Window>
  );
};
