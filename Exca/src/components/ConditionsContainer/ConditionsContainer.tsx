import { ChangeEvent } from "react"
import { Condition, ProjectView } from "../../types"

type ConditionsContainerType = {
    conditions: Condition[]
    project: ProjectView
}

export default function ConditionsContainer({ conditions, project } : ConditionsContainerType) {
    const handle = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {

    }

    const getValue = (id: number) : string=> {
        // project?.lease_request?.conditions.find(c => c.condition_id === id)?.value
        return ''
    }
    const getChecked = (id: number) : boolean => {
        // project?.lease_request?.conditions.find(c => c.condition_id === id)?.is_active
        return true
    }

    const getArray = (options: string) : string[] => JSON.parse(options);

    return (
        <div className="conditions-list">
            {conditions.map(condition => (
                <div className='condition-container' key={condition.id}>
                    <label htmlFor={condition.id.toString()}>{condition.name}</label>

                    {condition.type_id === 1 && (
                        <input value={getValue(condition.id)} onChange={handle} type='text' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 2 && (
                        <input value={getValue(condition.id)} onChange={handle} type='number' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 3 && (
                        <input value={getValue(condition.id)} onChange={handle} type='date' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 4 && (
                        <div className='checkbox'>
                            <input checked={getChecked(condition.id)} onChange={handle} type='checkbox' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                        </div>
                    )}
                    {condition.type_id === 5 && (
                        <select value={getValue(condition.id)} onChange={handle} name={condition.name} id={condition.id.toString()}>
                            <option value="">Selecciona una opción</option>
                            {getArray(condition.options).map(option => (
                                <option value={option} key={option}>{option}</option>
                            ))}
                        </select>
                    )}
                </div>
            ))}
        </div>
    )
}
