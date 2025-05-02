import { ChangeEvent, Dispatch } from "react"
import { Condition, ProjectView, TechnicalCaseConditionCreate } from "../../types"
import { getConditionRules } from "../../utils/conditionsRules"
import { isNullOrEmpty } from "../../utils"

type ConditionsContainerType = {
    conditions: Condition[]
    project: ProjectView
    setConditions: Dispatch<React.SetStateAction<TechnicalCaseConditionCreate[]>>
    currentConditions: TechnicalCaseConditionCreate[]
}

export default function ConditionsContainer({ conditions, project, setConditions, currentConditions } : ConditionsContainerType) {
    const handleChange = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { name, value } = e.target
        const isInput = e.target instanceof HTMLInputElement
        const condition = conditions.find(c => c.name === name)
        if (!condition) return

        setConditions(prev => {
            const existing = prev.find(c => c.condition_id === condition.id)
            if (isNullOrEmpty(value)) {
                return prev.filter(c => c.condition_id !== condition.id)
            }
            const updated = {
                id: condition.id,
                condition_id: condition.id,
                value,
                is_active: isInput && e.target instanceof HTMLInputElement ? e.target.checked : false
            }
            return existing 
            ? prev.map(c => c.condition_id === condition.id ? updated : c)
            : [...prev, updated]
        })

    }

    const getValue = (id: number) => {
        const value = getConditionRules(id, conditions, project!).value;
        return typeof value === 'boolean' ? value.toString() : value;
    }

    const getChecked = (id: number) => project?.lease_request?.conditions.find(c => c.condition_id === id)?.is_active
    const getArray = (options: string) : string[] => JSON.parse(options);

    return (
        <div className="conditions-list">
            {conditions.map(condition => (
                <div className='condition-container' key={condition.id}>
                    <label htmlFor={condition.id.toString()}>{condition.name}</label>

                    {condition.type_id === 1 && (
                        <input value={getValue(condition.id)} onChange={handleChange} type='text' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 2 && (
                        <input value={getValue(condition.id)} onChange={handleChange} type='number' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 3 && (
                        <input value={getValue(condition.id)} onChange={handleChange} type='date' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 4 && (
                        <div className='checkbox'>
                            <input checked={getChecked(condition.id)} onChange={handleChange} type='checkbox' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                            <span className="checkmark"></span>
                        </div>
                    )}
                    {condition.type_id === 5 && (
                        <select value={getValue(condition.id)} onChange={handleChange} name={condition.name} id={condition.id.toString()}>
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
