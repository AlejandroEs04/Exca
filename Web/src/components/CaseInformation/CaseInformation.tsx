import { ConditionCase } from "../../types"

type CaseInformationProps = {
    conditions: ConditionCase[]
    title: string
}

export default function CaseInformation({ conditions, title } : CaseInformationProps) {
    const getValue = (id: number) => conditions.find(c => c.condition_id === id)?.value
    const getChecked = (id: number) => conditions.find(c => c.condition_id === id)?.is_active

    return (
        <>
            <h2>{title}</h2>
            <div className='conditions-list'>
                {conditions.map(condition => (
                    <div className='condition-container' key={condition.id}>
                        <label htmlFor={condition.condition.id.toString()}>{condition.condition.name}</label>
                        {condition.condition.type_id !== 4 ? (
                            <input disabled defaultValue={getValue(condition.condition_id)} type='text' name={condition.condition.name} id={condition.condition.id.toString()} placeholder={condition.condition.name} />
                        ) : (
                            <div className='checkbox'>
                                <input disabled defaultChecked={getChecked(condition.condition_id)} type='checkbox' name={condition.condition.name} id={condition.condition.id.toString()} placeholder={condition.condition.name} />
                                <span className="checkmark"></span>
                            </div>
                        )}
                    </div>
                ))}
            </div>
        </>
    )
}
